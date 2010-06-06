" ==============================================================
" TwitVim - Post to Twitter from Vim
" Based on Twitter Vim script by Travis Jeffery <eatsleepgolf@gmail.com>
"
" Version: 0.4.7
" License: Vim license. See :help license
" Language: Vim script
" Maintainer: Po Shan Cheah <morton@mortonfox.com>
" Created: March 28, 2008
" Last updated: March 13, 2010
"
" GetLatestVimScripts: 2204 1 twitvim.vim
" ==============================================================

" Load this module only once.
if exists('loaded_twitvim')
    finish
endif
let loaded_twitvim = 1

" Avoid side-effects from cpoptions setting.
let s:save_cpo = &cpo
set cpo&vim

" The extended character limit is 246. Twitter will display a tweet longer than
" 140 characters in truncated form with a link to the full tweet. If that is
" undesirable, set s:char_limit to 140.
let s:char_limit = 246

" Allow the user to override the API root, e.g. for identi.ca, which offers a
" Twitter-compatible API.
function! s:get_api_root()
    return exists('g:twitvim_api_root') ? g:twitvim_api_root : "http://api.twitter.com/1"
endfunction

" Allow user to set the format for retweets.
function! s:get_retweet_fmt()
    return exists('g:twitvim_retweet_format') ? g:twitvim_retweet_format : "RT %s: %t"
endfunction

" Allow user to enable Python networking code by setting twitvim_enable_python.
function! s:get_enable_python()
    return exists('g:twitvim_enable_python') ? g:twitvim_enable_python : 0
endfunction

" Allow user to enable Perl networking code by setting twitvim_enable_perl.
function! s:get_enable_perl()
    return exists('g:twitvim_enable_perl') ? g:twitvim_enable_perl : 0
endfunction

" Allow user to enable Ruby code by setting twitvim_enable_ruby.
function! s:get_enable_ruby()
    return exists('g:twitvim_enable_ruby') ? g:twitvim_enable_ruby : 0
endfunction

" Allow user to enable Tcl code by setting twitvim_enable_tcl.
function! s:get_enable_tcl()
    return exists('g:twitvim_enable_tcl') ? g:twitvim_enable_tcl : 0
endfunction

" Get proxy setting from twitvim_proxy in .vimrc or _vimrc.
" Format is proxysite:proxyport
function! s:get_proxy()
    return exists('g:twitvim_proxy') ? g:twitvim_proxy : ''
endfunction

" If twitvim_proxy_login exists, use that as the proxy login.
" Format is proxyuser:proxypassword
" If twitvim_proxy_login_b64 exists, use that instead. This is the proxy
" user:password in base64 encoding.
function! s:get_proxy_login()
    if exists('g:twitvim_proxy_login_b64') && g:twitvim_proxy_login_b64 != ''
	return g:twitvim_proxy_login_b64
    else
	return exists('g:twitvim_proxy_login') ? g:twitvim_proxy_login : ''
    endif
endfunction

" Get twitvim_count, if it exists. This will be the number of tweets returned
" by :FriendsTwitter, :UserTwitter, and :SearchTwitter.
function! s:get_count()
    if exists('g:twitvim_count')
	if g:twitvim_count < 1
	    return 1
	elseif g:twitvim_count > 200
	    return 200
	else
	    return g:twitvim_count
	endif
    endif
    return 0
endfunction

" User setting to show/hide header in the buffer. Default: show header.
function! s:get_show_header()
    return exists('g:twitvim_show_header') ? g:twitvim_show_header : 1
endfunction

" Display an error message in the message area.
function! s:errormsg(msg)
    redraw
    echohl ErrorMsg
    echomsg a:msg
    echohl None
endfunction

" Display a warning message in the message area.
function! s:warnmsg(msg)
    redraw
    echohl WarningMsg
    echo a:msg
    echohl None
endfunction

" Get Twitter login info from twitvim_login in .vimrc or _vimrc.
" Format is username:password
" If twitvim_login_b64 exists, use that instead. This is the user:password
" in base64 encoding.
" Use this function if the API call doesn't require authentication but
" can use it if available.
function! s:get_twitvim_login_noerror()
    if exists('g:twitvim_login_b64') && g:twitvim_login_b64 != ''
	return g:twitvim_login_b64
    elseif exists('g:twitvim_login') && g:twitvim_login != ''
	return g:twitvim_login
    else
	return ''
    endif
endfunction

" Reset login info.
function! s:reset_twitvim_login()
    unlet! g:twitvim_login
    unlet! g:twitvim_login_b64
endfunction

" Verify login info. This will be used to check whether a username and password
" pair entered by the user is a valid login.
"
" Returns 1 if login succeeded, 0 if login failed, <0 for other errors.
function! s:check_twitvim_login(user, password)
    let login = a:user.':'.a:password

    redraw
    echo "Logging into Twitter..."

    let url = s:get_api_root()."/account/verify_credentials.xml"
    let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), {})
    if error =~ '401'
	return 0
    endif

    if error != ''
	call s:errormsg("Error logging into Twitter: ".error)
	return -1
    endif

    " The following check should not be required because Twitter is supposed to
    " return a 401 HTTP status on login failure, but you never know with
    " Twitter.
    let error = s:xml_get_element(output, 'error')
    if error =~ '\ccould not authenticate'
	return 0
    endif

    if error != ''
	call s:errormsg("Error logging into Twitter: ".error)
	return -1
    endif

    redraw
    echo "Twitter login succeeded."

    return 1
endfunction

" Ask user for Twitter login info.
" Returns user:password. Also saves it in g:twitvim_login for future use.
" Returns empty string if login canceled or failed.
function! s:prompt_twitvim_login()
    let failed = 0

    while 1
	call inputsave()
	redraw
	let user = input((failed ? 'Login failed. Try again. ' : 'Please log in. ')."Twitter username (Esc=exit): ")
	call inputrestore()

	if user == ''
	    call s:warnmsg("Twitter login not set.")
	    return ''
	endif

	call inputsave()
	redraw
	let pass = inputsecret("Twitter password (Esc=exit): ")
	call inputrestore()

	if pass == ''
	    call s:warnmsg("Twitter login not set.")
	    return ''
	endif

	let result = s:check_twitvim_login(user, pass)
	if result < 0
	    " Login didn't succeed or fail but there was some kind of error.
	    return ''
	endif

	if result > 0
	    " Login succeeded.
	    break
	endif

	let failed = 1
    endwhile

    call s:reset_twitvim_login()
    let g:twitvim_login = user.':'.pass
    return g:twitvim_login
endfunction

" Get Twitter login info from twitvim_login in .vimrc or _vimrc.
" Format is username:password
" If twitvim_login_b64 exists, use that instead. This is the user:password
" in base64 encoding.
function! s:get_twitvim_login()
    let login = s:get_twitvim_login_noerror()
    if login == ''

	" Prompt user to enter login info if not already configured.
	let login = s:prompt_twitvim_login()
	if login == ''
	    return ''
	endif

	" Beep and error-highlight 
	" execute "normal \<Esc>"
	" call s:errormsg('Twitter login not set. Please add to .vimrc: let twitvim_login="USER:PASS"')
	" return ''
    endif
    return login
endfunction

let s:cached_login = ''
let s:cached_username = ''

" Get Twitter user name by verifying login credentials
function! s:get_twitvim_username()
    let login = s:get_twitvim_login()
    if login == ''
	return ''
    endif

    " If we already got the info, no need to get it again.
    if login == s:cached_login
	return s:cached_username
    endif

    redraw
    echo "Verifying login credentials with Twitter..."

    let url = s:get_api_root()."/account/verify_credentials.xml"
    let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), {})
    if error != ''
	call s:errormsg("Error verifying login credentials: ".error)
	return
    endif

    let error = s:xml_get_element(output, 'error')
    if error != ''
	call s:errormsg("Error verifying login credentials: ".error)
	return
    endif

    redraw
    echo "Twitter login credentials verified."

    let username = s:xml_get_element(output, 'screen_name')

    " Save it so we don't have to do it again unless the user switches to
    " a different login.
    let s:cached_login = login
    let s:cached_username = username

    return username
endfunction

" If set, twitvim_cert_insecure turns off certificate verification if using
" https Twitter API over cURL or Ruby.
function! s:get_twitvim_cert_insecure()
    return exists('g:twitvim_cert_insecure') ? g:twitvim_cert_insecure : 0
endfunction

" === XML helper functions ===

" Get the content of the n'th element in a series of elements.
function! s:xml_get_nth(xmlstr, elem, n)
    let matchres = matchlist(a:xmlstr, '<'.a:elem.'\%( [^>]*\)\?>\(.\{-}\)</'.a:elem.'>', -1, a:n)
    return matchres == [] ? "" : matchres[1]
endfunction

" Get the content of the specified element.
function! s:xml_get_element(xmlstr, elem)
    return s:xml_get_nth(a:xmlstr, a:elem, 1)
endfunction

" Remove any number of the specified element from the string. Used for removing
" sub-elements so that you can parse the remaining elements safely.
function! s:xml_remove_elements(xmlstr, elem)
    return substitute(a:xmlstr, '<'.a:elem.'>.\{-}</'.a:elem.'>', '', "g")
endfunction

" Get the attributes of the n'th element in a series of elements.
function! s:xml_get_attr_nth(xmlstr, elem, n)
    let matchres = matchlist(a:xmlstr, '<'.a:elem.'\s\+\([^>]*\)>', -1, a:n)
    if matchres == []
	return {}
    endif

    let matchcount = 1
    let attrstr = matchres[1]
    let attrs = {}

    while 1
	let matchres = matchlist(attrstr, '\(\w\+\)="\([^"]*\)"', -1, matchcount)
	if matchres == []
	    break
	endif

	let attrs[matchres[1]] = matchres[2]
	let matchcount += 1
    endwhile

    return attrs
endfunction

" Get attributes of the specified element.
function! s:xml_get_attr(xmlstr, elem)
    return s:xml_get_attr_nth(a:xmlstr, a:elem, 1)
endfunction

" === End of XML helper functions ===

" === Time parser ===

" Convert date to Julian date.
function! s:julian(year, mon, mday)
    let month = (a:mon - 1 + 10) % 12
    let year = a:year - month / 10
    return a:mday + 365 * year + year / 4 - year / 100 + year / 400 + ((month * 306) + 5) / 10
endfunction

" Calculate number of days since UNIX Epoch.
function! s:daygm(year, mon, mday)
    return s:julian(a:year, a:mon, a:mday) - s:julian(1970, 1, 1)
endfunction

" Convert date/time to UNIX time. (seconds since Epoch)
function! s:timegm(year, mon, mday, hour, min, sec)
    return a:sec + a:min * 60 + a:hour * 60 * 60 + s:daygm(a:year, a:mon, a:mday) * 60 * 60 * 24
endfunction

" Convert abbreviated month name to month number.
function! s:conv_month(s)
    let monthnames = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec']
    for mon in range(len(monthnames))
	if monthnames[mon] == tolower(a:s)
	    return mon + 1
	endif	
    endfor
    return 0
endfunction

function! s:timegm2(matchres, indxlist)
    let args = []
    for i in a:indxlist
	if i < 0
	    let mon = s:conv_month(a:matchres[-i])
	    if mon == 0
		return -1
	    endif
	    let args = add(args, mon)
	else
	    let args = add(args, a:matchres[i] + 0)
	endif
    endfor
    return call('s:timegm', args)
endfunction

" Parse a Twitter time string.
function! s:parse_time(str)
    " This timestamp format is used by Twitter in timelines.
    let matchres = matchlist(a:str, '^\w\+,\s\+\(\d\+\)\s\+\(\w\+\)\s\+\(\d\+\)\s\+\(\d\+\):\(\d\+\):\(\d\+\)\s\++0000$')
    if matchres != []
	return s:timegm2(matchres, [3, -2, 1, 4, 5, 6])
    endif

    " This timestamp format is used by Twitter in response to an update.
    let matchres = matchlist(a:str, '^\w\+\s\+\(\w\+\)\s\+\(\d\+\)\s\+\(\d\+\):\(\d\+\):\(\d\+\)\s\++0000\s\+\(\d\+\)$')
    if matchres != []
	return s:timegm2(matchres, [6, -1, 2, 3, 4, 5])
    endif
	
    " This timestamp format is used by Twitter Search.
    let matchres = matchlist(a:str, '^\(\d\+\)-\(\d\+\)-\(\d\+\)T\(\d\+\):\(\d\+\):\(\d\+\)Z$')
    if matchres != []
	return s:timegm2(matchres, range(1, 6))
    endif

    " This timestamp format is used by Twitter Rate Limit.
    let matchres = matchlist(a:str, '^\(\d\+\)-\(\d\+\)-\(\d\+\)T\(\d\+\):\(\d\+\):\(\d\+\)+00:00$')
    if matchres != []
	return s:timegm2(matchres, range(1, 6))
    endif

    return -1
endfunction

" Convert the Twitter timestamp to local time and simplify it.
function s:time_filter(str)
    if !exists("*strftime")
	return a:str
    endif
    let t = s:parse_time(a:str)
    return t < 0 ? a:str : strftime('%I:%M %p %b %d, %Y', t)
endfunction

" === End of time parser ===

" === Networking code ===

function! s:url_encode_char(c)
    let utf = iconv(a:c, &encoding, "utf-8")
    if utf == ""
	return a:c
    else
	let s = ""
	for i in range(strlen(utf))
	    let s .= printf("%%%02X", char2nr(utf[i]))
	endfor
	return s
    endif
endfunction

" URL-encode a string.
function! s:url_encode(str)
    return substitute(a:str, '[^a-zA-Z0-9_-]', '\=s:url_encode_char(submatch(0))', 'g')
endfunction

" Use curl to fetch a web page.
function! s:curl_curl(url, login, proxy, proxylogin, parms)
    let error = ""
    let output = ""

    let curlcmd = "curl -s -f -S "

    if s:get_twitvim_cert_insecure()
	let curlcmd .= "-k "
    endif

    if a:proxy != ""
	let curlcmd .= '-x "'.a:proxy.'" '
    endif

    if a:proxylogin != ""
	if stridx(a:proxylogin, ':') != -1
	    let curlcmd .= '-U "'.a:proxylogin.'" '
	else
	    let curlcmd .= '-H "Proxy-Authorization: Basic '.a:proxylogin.'" '
	endif
    endif

    if a:login != ""
	if stridx(a:login, ':') != -1
	    let curlcmd .= '-u "'.a:login.'" '
	else
	    let curlcmd .= '-H "Authorization: Basic '.a:login.'" '
	endif
    endif

    for [k, v] in items(a:parms)
	let curlcmd .= '-d "'.s:url_encode(k).'='.s:url_encode(v).'" '
    endfor

    let curlcmd .= '"'.a:url.'"'

    let output = system(curlcmd)
    if v:shell_error != 0
	let error = output
    endif

    return [ error, output ]
endfunction

" Check if we can use Python.
function! s:check_python()
    let can_python = 1
    python <<EOF
import vim
try:
    import urllib
    import urllib2
    import base64
except:
    vim.command('let can_python = 0')
EOF
    return can_python
endfunction

" Use Python to fetch a web page.
function! s:python_curl(url, login, proxy, proxylogin, parms)
    let error = ""
    let output = ""
    python <<EOF
import urllib
import urllib2
import base64
import vim

def make_base64(s):
    if s.find(':') != -1:
	s = base64.b64encode(s)
    return s

try:
    url = vim.eval("a:url")
    parms = vim.eval("a:parms")
    req = parms == {} and urllib2.Request(url) or urllib2.Request(url, urllib.urlencode(parms))

    login = vim.eval("a:login")
    if login != "":
	req.add_header('Authorization', 'Basic %s' % make_base64(login))

    proxy = vim.eval("a:proxy")
    if proxy != "":
	req.set_proxy(proxy, 'http')

    proxylogin = vim.eval("a:proxylogin")
    if proxylogin != "":
	req.add_header('Proxy-Authorization', 'Basic %s' % make_base64(proxylogin))

    f = urllib2.urlopen(req)
    out = ''.join(f.readlines())
except urllib2.HTTPError, (httperr):
    vim.command("let error='%s'" % str(httperr).replace("'", "''"))
else:
    vim.command("let output='%s'" % out.replace("'", "''"))
EOF

    return [ error, output ]
endfunction

" Check if we can use Perl.
function! s:check_perl()
    let can_perl = 1
    perl <<EOF
eval {
    require MIME::Base64;
    MIME::Base64->import;

    require LWP::UserAgent;
    LWP::UserAgent->import;
};

if ($@) {
    VIM::DoCommand('let can_perl = 0');
}
EOF
    return can_perl
endfunction

" Use Perl to fetch a web page.
function! s:perl_curl(url, login, proxy, proxylogin, parms)
    let error = ""
    let output = ""

    perl <<EOF
require MIME::Base64;
MIME::Base64->import;

require LWP::UserAgent;
LWP::UserAgent->import;

sub make_base64 {
    my $s = shift;
    $s =~ /:/ ? encode_base64($s) : $s;
}

my $ua = LWP::UserAgent->new;

my $url = VIM::Eval('a:url');

my $login = VIM::Eval('a:login');
$login ne '' and $ua->default_header('Authorization' => 'Basic '.make_base64($login));

my $proxy = VIM::Eval('a:proxy');
$proxy ne '' and $ua->proxy('http', "http://$proxy");

my $proxylogin = VIM::Eval('a:proxylogin');
$proxylogin ne '' and $ua->default_header('Proxy-Authorization' => 'Basic '.make_base64($proxylogin));

my %parms = ();
my $keys = VIM::Eval('keys(a:parms)');
for $k (split(/\n/, $keys)) {
    $parms{$k} = VIM::Eval("a:parms['$k']");
}

my $response = %parms ? $ua->post($url, \%parms) : $ua->get($url);
if ($response->is_success) {
    my $output = $response->content;
    $output =~ s/'/''/g;
    VIM::DoCommand("let output ='$output'");
}
else {
    my $error = $response->status_line;
    $error =~ s/'/''/g;
    VIM::DoCommand("let error ='$error'");
}
EOF

    return [ error, output ]
endfunction

" Check if we can use Ruby.
"
" Note: Before the networking code will function in Ruby under Windows, you
" need the patch from here:
" http://www.mail-archive.com/vim_dev@googlegroups.com/msg03693.html
"
" and Bram's correction to the patch from here:
" http://www.mail-archive.com/vim_dev@googlegroups.com/msg03713.html
"
function! s:check_ruby()
    let can_ruby = 1
    ruby <<EOF
begin
    require 'net/http'
    require 'net/https'
    require 'uri'
    require 'Base64'
rescue LoadError
    VIM.command('let can_ruby = 0')
end
EOF
    return can_ruby
endfunction

" Use Ruby to fetch a web page.
function! s:ruby_curl(url, login, proxy, proxylogin, parms)
    let error = ""
    let output = ""

    ruby <<EOF
require 'net/http'
require 'net/https'
require 'uri'
require 'Base64'

def make_base64(s)
    s =~ /:/ ? Base64.encode64(s) : s
end

def parse_user_password(s)
    (s =~ /:/ ? s : Base64.decode64(s)).split(':', 2)    
end

url = URI.parse(VIM.evaluate('a:url'))
httpargs = [ url.host, url.port ]

proxy = VIM.evaluate('a:proxy')
if proxy != ''
    prox = URI.parse("http://#{proxy}")
    httpargs += [ prox.host, prox.port ]
end

proxylogin = VIM.evaluate('a:proxylogin')
if proxylogin != ''
    httpargs += parse_user_password(proxylogin)
end

net = Net::HTTP.new(*httpargs)

net.use_ssl = (url.scheme == 'https')

# Disable certificate verification if user sets this variable.
cert_insecure = VIM.evaluate('s:get_twitvim_cert_insecure()')
if cert_insecure != '0'
    net.verify_mode = OpenSSL::SSL::VERIFY_NONE
end

parms = {}
keys = VIM.evaluate('keys(a:parms)')

# Vim patch 7.2.374 adds support to if_ruby for Vim types. So keys() will
# actually return a Ruby array instead of a newline-delimited string.
# So we only need to split the string if VIM.evaluate returns a string.
# If it's already an array, leave it alone.

keys = keys.split(/\n/) if keys.is_a? String

keys.each { |k|
    parms[k] = VIM.evaluate("a:parms['#{k}']")
}

begin
    res = net.start { |http| 
	path = "#{url.path}?#{url.query}"
	if parms == {}
	    req = Net::HTTP::Get.new(path)
	else
	    req = Net::HTTP::Post.new(path)
	    req.set_form_data(parms)
	end

	login = VIM.evaluate('a:login')
	if login != ''
	    req.add_field 'Authorization', "Basic #{make_base64(login)}"
	end

	#    proxylogin = VIM.evaluate('a:proxylogin')
	#    if proxylogin != ''
	#	req.add_field 'Proxy-Authorization', "Basic #{make_base64(proxylogin)}"
	#    end

	http.request(req)
    }
    case res
    when Net::HTTPSuccess
	output = res.body.gsub("'", "''")
	VIM.command("let output='#{output}'")
    else
	error = "#{res.code} #{res.message}".gsub("'", "''")
	VIM.command("let error='#{error}'")
    end
rescue SocketError
    VIM.command("let error='#{ERROR_INFO}'")
end
EOF

    return [error, output]
endfunction

" Check if we can use Tcl.
"
" Note: ActiveTcl 8.5 doesn't include Tcllib in the download. You need to run the following after installing ActiveTcl:
"
"    teacup install tcllib
"
function! s:check_tcl()
    let can_tcl = 1
    tcl <<EOF
if [catch {
    package require http
    package require uri
    package require base64
} result] {
    ::vim::command "let can_tcl = 0"
}
EOF
    return can_tcl
endfunction

" Use Tcl to fetch a web page.
function! s:tcl_curl(url, login, proxy, proxylogin, parms)
    let error = ""
    let output = ""

    tcl << EOF
package require http
package require uri
package require base64

proc make_base64 {s} {
    if { [string first : $s] >= 0 } {
	return [base64::encode $s]
    }
    return $s
}

set url [::vim::expr a:url]

set headers [list]

::http::config -proxyhost ""
set proxy [::vim::expr a:proxy]
if { $proxy != "" } {
    array set prox [uri::split "http://$proxy"]
    ::http::config -proxyhost $prox(host)
    ::http::config -proxyport $prox(port)
}

set proxylogin [::vim::expr a:proxylogin]
if { $proxylogin != "" } {
    lappend headers "Proxy-Authorization" "Basic [make_base64 $proxylogin]"
}

set login [::vim::expr a:login]
if { $login != "" } {
    lappend headers "Authorization" "Basic [make_base64 $login]"
}

set parms [list]
set keys [split [::vim::expr "keys(a:parms)"] "\n"]
if { [llength $keys] > 0 } {
    foreach key $keys {
	lappend parms $key [::vim::expr "a:parms\['$key']"]
    }
    set query [eval [concat ::http::formatQuery $parms]]
    set res [::http::geturl $url -headers $headers -query $query]
} else {
    set res [::http::geturl $url -headers $headers]
}

upvar #0 $res state

if { $state(status) == "ok" } {
    if { [ ::http::ncode $res ] >= 400 } {
	set error $state(http)
	::vim::command "let error = '$error'"
    } else {
	set output [string map {' ''} $state(body)]
	::vim::command "let output = '$output'"
    }
} else {
    if { [ info exists state(error) ] } {
	set error [string map {' ''} $state(error)]
    } else {
	set error "$state(status) error"
    }
    ::vim::command "let error = '$error'"
}

::http::cleanup $res
EOF

    return [error, output]
endfunction

" Find out which method we can use to fetch a web page.
function! s:get_curl_method()
    if !exists('s:curl_method')
	let s:curl_method = 'curl'

	if s:get_enable_perl() && has('perl')
	    if s:check_perl()
		let s:curl_method = 'perl'
	    endif
	elseif s:get_enable_python() && has('python')
	    if s:check_python()
		let s:curl_method = 'python'
	    endif
	elseif s:get_enable_ruby() && has('ruby')
	    if s:check_ruby()
		let s:curl_method = 'ruby'
	    endif
	elseif s:get_enable_tcl() && has('tcl')
	    if s:check_tcl()
		let s:curl_method = 'tcl'
	    endif
	endif
    endif

    return s:curl_method
endfunction

function! s:run_curl(url, login, proxy, proxylogin, parms)
    return s:{s:get_curl_method()}_curl(a:url, a:login, a:proxy, a:proxylogin, a:parms)
endfunction

function! s:reset_curl_method()
    if exists('s:curl_method')	
	unlet s:curl_method
    endif
endfunction

function! s:show_curl_method()
    echo 'Method:' s:get_curl_method()
endfunction

" For debugging. Reset networking method.
if !exists(":TwitVimResetMethod")
    command TwitVimResetMethod :call <SID>reset_curl_method()
endif

" For debugging. Show current networking method.
if !exists(":TwitVimShowMethod")
    command TwitVimShowMethod :call <SID>show_curl_method()
endif

" === End of networking code ===

" === Buffer stack code ===

" Each buffer record holds the following fields:
"
" buftype: Buffer type = dmrecv, dmsent, search, public, friends, user, replies, list
" user: For user buffers if other than current user
" list: List slug if displaying a Twitter list.
" page: Keep track of pagination.
" statuses: Tweet IDs. For use by in_reply_to_status_id
" inreplyto: IDs of predecessor messages for @-replies.
" dmids: Direct Message IDs.
" buffer: The buffer text.
" showheader: 1 if header is shown in this buffer, 0 if header is hidden.

let s:curbuffer = {}

let s:bufstack = []

" Maximum items in the buffer stack. Adding a new item after this limit will
" get rid of the first item.
let s:bufstackmax = 10

" Buffer stack pointer. -1 if no items yet. May not point to the end of the
" list if user has gone back one or more buffers.
let s:bufstackptr = -1

" Add current buffer to the buffer stack at the next position after current.
" Remove all buffers after that.
function! s:add_buffer()

    " If stack is already full, remove the buffer at the bottom of the stack to
    " make room.
    if s:bufstackptr >= s:bufstackmax
	call remove(s:bufstack, 0)
	let s:bufstackptr -= 1
    endif

    let s:bufstackptr += 1

    " Suppress errors because there may not be anything to remove after current
    " position.
    silent! call remove(s:bufstack, s:bufstackptr, -1)

    call add(s:bufstack, s:curbuffer)
endfunction

" If current buffer is same type as the buffer at the buffer stack pointer then
" just copy it into the buffer stack. Otherwise, add it to buffer stack.
function! s:save_buffer()
    if s:curbuffer == {}
	return
    endif

    " Save buffer contents and cursor position.
    let twit_bufnr = bufwinnr('^'.s:twit_winname.'$')
    if twit_bufnr > 0
	let curwin = winnr()
	execute twit_bufnr . "wincmd w"
	let s:curbuffer.buffer = getline(1, '$')
	let s:curbuffer.view = winsaveview()
	execute curwin .  "wincmd w"
    else
	let s:curbuffer.view = {}
    endif

    " If current buffer is the same type as buffer at the top of the stack,
    " then just copy it.
    if s:bufstackptr >= 0 && s:curbuffer.buftype == s:bufstack[s:bufstackptr].buftype && s:curbuffer.list == s:bufstack[s:bufstackptr].list && s:curbuffer.user == s:bufstack[s:bufstackptr].user && s:curbuffer.page == s:bufstack[s:bufstackptr].page

	let s:bufstack[s:bufstackptr] = deepcopy(s:curbuffer)
	return
    endif

    " Otherwise, push the current buffer onto the stack.
    call s:add_buffer()
endfunction

" Go back one buffer in the buffer stack.
function! s:back_buffer()
    call s:save_buffer()

    if s:bufstackptr < 1
	call s:warnmsg("Already at oldest buffer. Can't go back further.")
	return -1
    endif

    let s:bufstackptr -= 1
    let s:curbuffer = deepcopy(s:bufstack[s:bufstackptr])

    call s:twitter_wintext_view(s:curbuffer.buffer, "timeline", s:curbuffer.view)
    return 0
endfunction

" Go forward one buffer in the buffer stack.
function! s:fwd_buffer()
    call s:save_buffer()

    if s:bufstackptr + 1 >= len(s:bufstack)
	call s:warnmsg("Already at newest buffer. Can't go forward.")
	return -1
    endif

    let s:bufstackptr += 1
    let s:curbuffer = deepcopy(s:bufstack[s:bufstackptr])

    call s:twitter_wintext_view(s:curbuffer.buffer, "timeline", s:curbuffer.view)
    return 0
endfunction

if !exists(":BackTwitter")
    command BackTwitter :call <SID>back_buffer()
endif
if !exists(":ForwardTwitter")
    command ForwardTwitter :call <SID>fwd_buffer()
endif

" For debugging. Show the buffer stack.
function! s:show_bufstack()
    for i in range(len(s:bufstack) - 1, 0, -1)
	echo i.':' 'type='.s:bufstack[i].buftype 'user='.s:bufstack[i].user 'page='.s:bufstack[i].page
    endfor
endfunction

if !exists(":TwitVimShowBufstack")
    command TwitVimShowBufstack :call <SID>show_bufstack()
endif

" For debugging. Show curbuffer variable.
if !exists(":TwitVimShowCurbuffer")
    command TwitVimShowCurbuffer :echo s:curbuffer
endif

" === End of buffer stack code ===

" Add update to Twitter buffer if public, friends, or user timeline.
function! s:add_update(output)
    if has_key(s:curbuffer, 'buftype') && (s:curbuffer.buftype == "public" || s:curbuffer.buftype == "friends" || s:curbuffer.buftype == "user" || s:curbuffer.buftype == "replies" || s:curbuffer.buftype == "list" || s:curbuffer.buftype == "retweeted_by_me" || s:curbuffer.buftype == "retweeted_to_me")

	" Parse the output from the Twitter update call.
	let line = s:format_status_xml(a:output)

	" Line number where new tweet will be inserted. It should be 3 if
	" header is shown and 1 if header is hidden.
	let insline = s:curbuffer.showheader ? 3 : 1

	" Add the status ID to the current buffer's statuses list.
	call insert(s:curbuffer.statuses, s:xml_get_element(a:output, 'id'), insline)

	" Add in-reply-to ID to current buffer's in-reply-to list.
	call insert(s:curbuffer.inreplyto, s:xml_get_element(a:output, 'in_reply_to_status_id'), insline)

	let twit_bufnr = bufwinnr('^'.s:twit_winname.'$')
	if twit_bufnr > 0
	    let curwin = winnr()
	    execute twit_bufnr . "wincmd w"
	    set modifiable
	    call append(insline - 1, line)
	    execute "normal! ".insline."G"
	    set nomodifiable
	    let s:curbuffer.buffer = getline(1, '$')
	    execute curwin .  "wincmd w"
	endif
    endif
endfunction

" Count number of characters in a multibyte string. Use technique from
" :help strlen().
function! s:mbstrlen(s)
    return strlen(substitute(a:s, ".", "x", "g"))
endfunction

" Common code to post a message to Twitter.
function! s:post_twitter(mesg, inreplyto)
    let login = s:get_twitvim_login()
    if login == ''
	return -1
    endif

    let parms = {}

    " Add in_reply_to_status_id if status ID is available.
    if a:inreplyto != 0
	let parms["in_reply_to_status_id"] = a:inreplyto
    endif

    let mesg = a:mesg

    " Remove trailing newline. You see that when you visual-select an entire
    " line. Don't let it count towards the tweet length.
    let mesg = substitute(mesg, '\n$', '', "")

    " Convert internal newlines to spaces.
    let mesg = substitute(mesg, '\n', ' ', "g")

    let mesglen = s:mbstrlen(mesg)

    " Check tweet length. Note that the tweet length should be checked before
    " URL-encoding the special characters because URL-encoding increases the
    " string length.
    if mesglen > s:char_limit
	call s:warnmsg("Your tweet has ".(mesglen - s:char_limit)." too many characters. It was not sent.")
    elseif mesglen < 1
	call s:warnmsg("Your tweet was empty. It was not sent.")
    else
	redraw
	echo "Sending update to Twitter..."

	let url = s:get_api_root()."/statuses/update.xml?source=twitvim"
	let parms["status"] = mesg

	let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), parms)

	if error != ''
	    call s:errormsg("Error posting your tweet: ".error)
	else
	    call s:add_update(output)
	    redraw
	    echo "Your tweet was sent. You used ".mesglen." characters."
	endif
    endif
endfunction

" Prompt user for tweet and then post it.
" If initstr is given, use that as the initial input.
function! s:CmdLine_Twitter(initstr, inreplyto)
    " Do this here too to check for twitvim_login. This is to avoid having the
    " user type in the message only to be told that his configuration is
    " incomplete.
    let login = s:get_twitvim_login()
    if login == ''
	return -1
    endif

    call inputsave()
    redraw
    let mesg = input("Your Twitter: ", a:initstr)
    call inputrestore()
    call s:post_twitter(mesg, a:inreplyto)
endfunction

" Extract the user name from a line in the timeline.
function! s:get_user_name(line)
    let line = substitute(a:line, '^+ ', '', '')
    let matchres = matchlist(line, '^\(\w\+\):')
    return matchres != [] ? matchres[1] : ""
endfunction

" This is for a local mapping in the timeline. Start an @-reply on the command
" line to the author of the tweet on the current line.
function! s:Quick_Reply()
    let username = s:get_user_name(getline('.'))
    if username != ""
	" If the status ID is not available, get() will return 0 and
	" post_twitter() won't add in_reply_to_status_id to the update.
	call s:CmdLine_Twitter('@'.username.' ', get(s:curbuffer.statuses, line('.')))
    endif
endfunction

" Extract all user names from a line in the timeline. Return the poster's name as well as names from all the @replies.
function! s:get_all_names(line)
    let names = []
    let dictnames = {}

    let username = s:get_user_name(getline('.'))
    if username != ""
	" Add this to the beginning of the list because we want the tweet
	" author to be the main addressee in the reply to all.
	let names = [ username ]
	let dictnames[tolower(username)] = 1
    endif

    let matchcount = 1
    while 1
	let matchres = matchlist(a:line, '@\(\w\+\)', -1, matchcount)
	if matchres == []
	    break
	endif
	let name = matchres[1]
	" Don't add duplicate names.
	if !has_key(dictnames, tolower(name))
	    call add(names, name)
	    let dictnames[tolower(name)] = 1
	endif
	let matchcount += 1
    endwhile

    return names
endfunction

" Reply to everyone mentioned on a line in the timeline.
function! s:Reply_All()
    let names = s:get_all_names(getline('.'))

    " Remove the author from the reply list so that he doesn't end up replying
    " to himself.
    let user = s:get_twitvim_username()
    let names2 = []
    for name in names
	if name != user
	    call add(names2, name)
	endif
    endfor

    let replystr = '@'.join(names2, ' @').' '

    if names != []
	" If the status ID is not available, get() will return 0 and
	" post_twitter() won't add in_reply_to_status_id to the update.
	call s:CmdLine_Twitter(replystr, get(s:curbuffer.statuses, line('.')))
    endif
endfunction

" This is for a local mapping in the timeline. Start a direct message on the
" command line to the author of the tweet on the current line.
function! s:Quick_DM()
    let username = s:get_user_name(getline('.'))
    if username != ""
	" call s:CmdLine_Twitter('d '.username.' ', 0)
	call s:send_dm(username, '')
    endif
endfunction

" Allow user to switch to old-style retweets by setting twitvim_old_retweet.
function! s:get_old_retweet()
    return exists('g:twitvim_old_retweet') ? g:twitvim_old_retweet : 0
endfunction

" Extract the tweet text from a timeline buffer line.
function! s:get_tweet(line)
    let line = substitute(a:line, '^\w\+:\s\+', '', '')
    let line = substitute(line, '\s\+|[^|]\+|$', '', '')

    " Remove newlines.
    let line = substitute(line, "\n", '', 'g')

    return line
endfunction

" Retweet is for replicating a tweet from another user.
function! s:Retweet()
    let line = getline('.')
    let username = s:get_user_name(line)
    if username != ""
	let retweet = substitute(s:get_retweet_fmt(), '%s', '@'.username, '')
	let retweet = substitute(retweet, '%t', s:get_tweet(line), '')
	call s:CmdLine_Twitter(retweet, 0)
    endif
endfunction

" Use new-style retweet API to retweet a tweet from another user.
function! s:Retweet_2()

    " Do an old-style retweet if user has set twitvim_old_retweet.
    if s:get_old_retweet()
	call s:Retweet()
	return
    endif

    let status = get(s:curbuffer.statuses, line('.'))
    if status == 0
	" Fall back to old-style retweeting if we can't get this tweet's status
	" ID.
	call s:Retweet()
	return
    endif

    let login = s:get_twitvim_login()
    if login == ''
	return -1
    endif

    let parms = {}

    " Force POST instead of GET.
    let parms["dummy"] = "dummy1"

    let url = s:get_api_root()."/statuses/retweet/".status.".xml"

    redraw
    echo "Retweeting..."

    let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), parms)
    if error != ''
	call s:errormsg("Error retweeting: ".error)
    else
	call s:add_update(output)
	redraw
	echo "Retweeted."
    endif
endfunction

" Show which tweet this one is replying to below the current line.
function! s:show_inreplyto()
    let lineno = line('.')

    let inreplyto = get(s:curbuffer.inreplyto, lineno)
    if inreplyto == 0
	call s:warnmsg("No in-reply-to information for current line.")
	return
    endif

    let login = s:get_twitvim_login()
    if login == ''
	return -1
    endif

    redraw
    echo "Querying Twitter for in-reply-to tweet..."

    let url = s:get_api_root()."/statuses/show/".inreplyto.".xml"
    let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), {})
    if error != ''
	call s:errormsg("Error getting in-reply-to tweet: ".error)
	return
    endif

    let error = s:xml_get_element(output, 'error')
    if error != ''
	call s:errormsg("Error getting in-reply-to tweet: ".error)
	return
    endif

    let line = s:format_status_xml(output)

    " Add the status ID to the current buffer's statuses list.
    call insert(s:curbuffer.statuses, s:xml_get_element(output, 'id'), lineno + 1)

    " Add in-reply-to ID to current buffer's in-reply-to list.
    call insert(s:curbuffer.inreplyto, s:xml_get_element(output, 'in_reply_to_status_id'), lineno + 1)

    " Already in the correct buffer so no need to search or switch buffers.
    set modifiable
    call append(lineno, '+ '.line)
    set nomodifiable
    let s:curbuffer.buffer = getline(1, '$')

    redraw
    echo "In-reply-to tweet found."
endfunction

" Truncate a string. Add '...' to the end of string was longer than
" the specified number of characters.
function! s:strtrunc(s, len)
    let slen = strlen(substitute(a:s, ".", "x", "g"))
    let s = substitute(a:s, '^\(.\{,'.a:len.'}\).*$', '\1', '')
    if slen > a:len
	let s .= '...'
    endif
    return s
endfunction

" Delete tweet or DM on current line.
function! s:do_delete_tweet()
    let lineno = line('.')

    let isdm = (s:curbuffer.buftype == "dmrecv" || s:curbuffer.buftype == "dmsent")
    let obj = isdm ? "message" : "tweet"
    let uobj = isdm ? "Message" : "Tweet"

    let id = get(isdm ? s:curbuffer.dmids : s:curbuffer.statuses, lineno)

    let login = s:get_twitvim_login()
    if login == ''
	return -1
    endif

    " The delete API call requires POST, not GET, so we supply a fake parameter
    " to force run_curl() to use POST.
    let parms = {}
    let parms["id"] = id

    let url = s:get_api_root().'/'.(isdm ? "direct_messages" : "statuses")."/destroy/".id.".xml"
    let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), parms)
    if error != ''
	call s:errormsg("Error deleting ".obj.": ".error)
	return
    endif

    let error = s:xml_get_element(output, 'error')
    if error != ''
	call s:errormsg("Error deleting ".obj.": ".error)
	return
    endif

    if isdm
	call remove(s:curbuffer.dmids, lineno)
    else
	call remove(s:curbuffer.statuses, lineno)
	call remove(s:curbuffer.inreplyto, lineno)
    endif

    " Already in the correct buffer so no need to search or switch buffers.
    set modifiable
    normal! dd
    set nomodifiable
    let s:curbuffer.buffer = getline(1, '$')

    redraw
    echo uobj "deleted."
endfunction

" Delete tweet or DM on current line.
function! s:delete_tweet()
    let lineno = line('.')

    let isdm = (s:curbuffer.buftype == "dmrecv" || s:curbuffer.buftype == "dmsent")
    let obj = isdm ? "message" : "tweet"
    let uobj = isdm ? "Message" : "Tweet"

    let id = get(isdm ? s:curbuffer.dmids : s:curbuffer.statuses, lineno)
    if id == 0
	call s:warnmsg("No erasable ".obj." on current line.")
	return
    endif

    call inputsave()
    let answer = input('Delete "'.s:strtrunc(getline('.'), 40).'"? (y/n) ')
    call inputrestore()
    if answer == 'y' || answer == 'Y'
	call s:do_delete_tweet()
    else
	redraw
	echo uobj "not deleted."
    endif
endfunction

" Prompt user for tweet.
if !exists(":PosttoTwitter")
    command PosttoTwitter :call <SID>CmdLine_Twitter('', 0)
endif

nnoremenu Plugin.TwitVim.Post\ from\ cmdline :call <SID>CmdLine_Twitter('', 0)<cr>

" Post current line to Twitter.
if !exists(":CPosttoTwitter")
    command CPosttoTwitter :call <SID>post_twitter(getline('.'), 0)
endif

nnoremenu Plugin.TwitVim.Post\ current\ line :call <SID>post_twitter(getline('.'), 0)<cr>

" Post entire buffer to Twitter.
if !exists(":BPosttoTwitter")
    command BPosttoTwitter :call <SID>post_twitter(join(getline(1, "$")), 0)
endif

" Post visual selection to Twitter.
noremap <SID>Visual y:call <SID>post_twitter(@", 0)<cr>
noremap <unique> <script> <Plug>TwitvimVisual <SID>Visual
if !hasmapto('<Plug>TwitvimVisual')
    vmap <unique> <A-t> <Plug>TwitvimVisual

    " Allow Ctrl-T as an alternative to Alt-T.
    " Alt-T pulls down the Tools menu if the menu bar is enabled.
    vmap <unique> <C-t> <Plug>TwitvimVisual
endif

vmenu Plugin.TwitVim.Post\ selection <Plug>TwitvimVisual

" Launch web browser with the given URL.
function! s:launch_browser(url)
    if !exists('g:twitvim_browser_cmd') || g:twitvim_browser_cmd == ''
	" Beep and error-highlight 
	execute "normal! \<Esc>"
	call s:errormsg('Browser cmd not set. Please add to .vimrc: let twitvim_browser_cmd="browsercmd"')
	return -1
    endif

    let startcmd = has("win32") || has("win64") ? "!start " : "! "
    let endcmd = has("unix") ? "&" : ""

    " Escape characters that have special meaning in the :! command.
    let url = substitute(a:url, '!\|#\|%', '\\&', 'g')

    redraw
    echo "Launching web browser..."
    let v:errmsg = ""
    silent! execute startcmd g:twitvim_browser_cmd url endcmd
    if v:errmsg == ""
	redraw
	echo "Web browser launched."
    else
	call s:errormsg('Error launching browser: '.v:errmsg)
    endif
endfunction

" Launch web browser with the URL at the cursor position. If possible, this
" function will try to recognize a URL within the current word. Otherwise,
" it'll just use the whole word.
" If the cWORD happens to be @user or user:, show that user's timeline.
function! s:launch_url_cword()
    let s = expand("<cWORD>")

    " Handle @-replies by showing that user's timeline.
    let matchres = matchlist(s, '^@\(\w\+\)')
    if matchres != []
	call s:get_timeline("user", matchres[1], 1)
	return
    endif

    " Handle username: at the beginning of the line by showing that user's
    " timeline.
    let matchres = matchlist(s, '^\(\w\+\):$')
    if matchres != []
	call s:get_timeline("user", matchres[1], 1)
	return
    endif

    " Handle #-hashtags by showing the Twitter Search for that hashtag.
    let matchres = matchlist(s, '^\(#\w\+\)')
    if matchres != []
	call s:get_summize(matchres[1], 1)
	return
    endif

    let s = substitute(s, '.*\<\(\(http\|https\|ftp\)://\S\+\)', '\1', "")
    call s:launch_browser(s)
endfunction

" Call LongURL API on a shorturl to expand it.
function! s:call_longurl(url)
    redraw
    echo "Sending request to LongURL..."

    let url = 'http://api.longurl.org/v1/expand?url='.s:url_encode(a:url)
    let [error, output] = s:run_curl(url, '', s:get_proxy(), s:get_proxy_login(), {})
    if error != ''
	call s:errormsg("Error calling LongURL API: ".error)
	return ""
    else
	redraw
	echo "Received response from LongURL."

	let longurl = s:xml_get_element(output, 'long_url')
	if longurl != ""
	    return substitute(longurl, '<!\[CDATA\[\(.*\)]]>', '\1', '')
	endif

	let errormsg = s:xml_get_element(output, 'error')
	if errormsg != ""
	    call s:errormsg("LongURL error: ".errormsg)
	    return ""
	endif

	call s:errormsg("Unknown response from LongURL: ".output)
	return ""
    endif
endfunction

" Call LongURL API on the given string. If no string is provided, use the
" current word. In the latter case, this function will try to recognize a URL
" within the word. Otherwise, it'll just use the whole word.
function! s:do_longurl(s)
    let s = a:s
    if s == ""
	let s = expand("<cWORD>")
	let s = substitute(s, '.*\<\(\(http\|https\|ftp\)://\S\+\)', '\1', "")
    endif
    let result = s:call_longurl(s)
    if result != ""
	redraw
	echo s.' expands to '.result
    endif
endfunction

" Get info on the given user. If no user is provided, use the current word and
" strip off the @ or : if the current word is @user or user:. 
function! s:do_user_info(s)
    let s = a:s
    if s == ''
	let s = expand("<cword>")
	
	" Handle @-replies.
	let matchres = matchlist(s, '^@\(\w\+\)')
	if matchres != []
	    let s = matchres[1]
	else
	    " Handle username: at the beginning of the line.
	    let matchres = matchlist(s, '^\(\w\+\):$')
	    if matchres != []
		let s = matchres[1]
	    endif
	endif
    endif

    call s:get_user_info(s)
endfunction

" Decode HTML entities. Twitter gives those to us a little weird. For example,
" a '<' character comes to us as &amp;lt;
function! s:convert_entity(str)
    let s = a:str
    let s = substitute(s, '&amp;', '\&', 'g')
    let s = substitute(s, '&lt;', '<', 'g')
    let s = substitute(s, '&gt;', '>', 'g')
    let s = substitute(s, '&quot;', '"', 'g')
    let s = substitute(s, '&#\(\d\+\);','\=nr2char(submatch(1))', 'g')
    return s
endfunction

let s:twit_winname = "Twitter_".localtime()

" Set syntax highlighting in timeline window.
function! s:twitter_win_syntax(wintype)
    " Beautify the Twitter window with syntax highlighting.
    if has("syntax") && exists("g:syntax_on")
	" Reset syntax items in case there are any predefined in the new buffer.
	syntax clear

	" Twitter user name: from start of line to first colon.
	syntax match twitterUser /^.\{-1,}:/

	" Use the bars to recognize the time but hide the bars.
	syntax match twitterTime /|[^|]\+|$/ contains=twitterTimeBar
	syntax match twitterTimeBar /|/ contained

	" Highlight links in tweets.
	syntax match twitterLink "\<http://\S\+"
	syntax match twitterLink "\<https://\S\+"
	syntax match twitterLink "\<ftp://\S\+"

	" An @-reply must be preceded by whitespace and ends at a non-word
	" character.
	syntax match twitterReply "\S\@<!@\w\+"

	" A #-hashtag must be preceded by whitespace and ends at a non-word
	" character.
	syntax match twitterLink "\S\@<!#\w\+"

	if a:wintype != "userinfo"
	    " Use the extra star at the end to recognize the title but hide the
	    " star.
	    syntax match twitterTitle /^.\+\*$/ contains=twitterTitleStar
	    syntax match twitterTitleStar /\*$/ contained
	endif

	highlight default link twitterUser Identifier
	highlight default link twitterTime String
	highlight default link twitterTimeBar Ignore
	highlight default link twitterTitle Title
	highlight default link twitterTitleStar Ignore
	highlight default link twitterLink Underlined
	highlight default link twitterReply Label
    endif
endfunction

" Switch to the Twitter window if there is already one or open a new window for
" Twitter.
" Returns 1 if new window created, 0 otherwise.
function! s:twitter_win(wintype)
    let winname = a:wintype == "userinfo" ? s:user_winname : s:twit_winname
    let newwin = 0

    let twit_bufnr = bufwinnr('^'.winname.'$')
    if twit_bufnr > 0
	execute twit_bufnr . "wincmd w"
    else
	let newwin = 1
	execute "new " . winname
	setlocal noswapfile
	setlocal buftype=nofile
	setlocal bufhidden=delete 
	setlocal foldcolumn=0
	setlocal nobuflisted
	setlocal nospell

	" Launch browser with URL in visual selection or at cursor position.
	nnoremap <buffer> <silent> <A-g> :call <SID>launch_url_cword()<cr>
	nnoremap <buffer> <silent> <Leader>g :call <SID>launch_url_cword()<cr>
	vnoremap <buffer> <silent> <A-g> y:call <SID>launch_browser(@")<cr>
	vnoremap <buffer> <silent> <Leader>g y:call <SID>launch_browser(@")<cr>

	" Get user info for current word or selection.
	nnoremap <buffer> <silent> <Leader>p :call <SID>do_user_info("")<cr>
	vnoremap <buffer> <silent> <Leader>p y:call <SID>do_user_info(@")<cr>

	" Call LongURL API on current word or selection.
	nnoremap <buffer> <silent> <Leader>e :call <SID>do_longurl("")<cr>
	vnoremap <buffer> <silent> <Leader>e y:call <SID>do_longurl(@")<cr>

	if a:wintype != "userinfo"

	    " Quick reply feature for replying from the timeline.
	    nnoremap <buffer> <silent> <A-r> :call <SID>Quick_Reply()<cr>
	    nnoremap <buffer> <silent> <Leader>r :call <SID>Quick_Reply()<cr>

	    " Quick DM feature for direct messaging from the timeline.
	    nnoremap <buffer> <silent> <A-d> :call <SID>Quick_DM()<cr>
	    nnoremap <buffer> <silent> <Leader>d :call <SID>Quick_DM()<cr>

	    " Retweet feature for replicating another user's tweet.
	    nnoremap <buffer> <silent> <Leader>R :call <SID>Retweet_2()<cr>

	    " Reply to all feature.
	    nnoremap <buffer> <silent> <Leader><C-r> :call <SID>Reply_All()<cr>

	    " Show in-reply-to for current tweet.
	    nnoremap <buffer> <silent> <Leader>@ :call <SID>show_inreplyto()<cr>

	    " Delete tweet or message on current line.
	    nnoremap <buffer> <silent> <Leader>X :call <SID>delete_tweet()<cr>

	    " Refresh timeline.
	    nnoremap <buffer> <silent> <Leader><Leader> :call <SID>RefreshTimeline()<cr>

	    " Next page in timeline.
	    nnoremap <buffer> <silent> <C-PageDown> :call <SID>NextPageTimeline()<cr>

	    " Previous page in timeline.
	    nnoremap <buffer> <silent> <C-PageUp> :call <SID>PrevPageTimeline()<cr>

	endif

	" Go back and forth through buffer stack.
	nnoremap <buffer> <silent> <C-o> :call <SID>back_buffer()<cr>
	nnoremap <buffer> <silent> <C-i> :call <SID>fwd_buffer()<cr>
    endif

    call s:twitter_win_syntax(a:wintype)
    return newwin
endfunction

" Get a Twitter window and stuff text into it. If view is not an empty
" dictionary then restore the cursor position to the saved view.
function! s:twitter_wintext_view(text, wintype, view)
    let curwin = winnr()
    let newwin = s:twitter_win(a:wintype)

    set modifiable

    " Overwrite the entire buffer.
    " Need to use 'silent' or a 'No lines in buffer' message will appear.
    " Delete to the blackhole register "_ so that we don't affect registers.
    silent %delete _
    call setline('.', a:text)
    normal! 1G

    set nomodifiable

    " Restore the saved view if provided.
    if a:view != {}
	call winrestview(a:view)
    endif

    " Go back to original window after updating buffer. If a new window is
    " created then our saved curwin number is wrong so the best we can do is to
    " take the user back to the last-accessed window using 'wincmd p'.
    if newwin
	wincmd p
    else
	execute curwin .  "wincmd w"
    endif
endfunction

" Get a Twitter window and stuff text into it.
function! s:twitter_wintext(text, wintype)
    call s:twitter_wintext_view(a:text, a:wintype, {})
endfunction

" Format XML status as a display line.
function! s:format_status_xml(item)
    let item = a:item

    " Quick hack. Even though we're getting new-style retweets in the timeline
    " XML, we'll still use the old-style retweet text from it.
    let item = s:xml_remove_elements(item, 'retweeted_status')

    let user = s:xml_get_element(item, 'screen_name')
    let text = s:convert_entity(s:xml_get_element(item, 'text'))
    let pubdate = s:time_filter(s:xml_get_element(item, 'created_at'))

    return user.': '.text.' |'.pubdate.'|'
endfunction

" Show a timeline from XML stream data.
function! s:show_timeline_xml(timeline, tline_name, username, page)
    let matchcount = 1
    let text = []

    let s:curbuffer.dmids = []

    " Construct page title.

    let title = substitute(a:tline_name, '^.', '\u&', '')." timeline"
    if a:username != ''
	let title .= " for ".a:username
    endif

    " Special case titles for Retweets and Mentions.
    if a:tline_name == "retweeted_to_me"
	let title = "Retweets by others"
    elseif a:tline_name == "retweeted_by_me"
	let title = "Retweets by you"
    elseif a:tline_name == "replies"
	let title = "Mentions timeline"
    endif

    if a:page > 1
	let title .= ' (page '.a:page.')'
    endif

    let s:curbuffer.showheader = s:get_show_header()
    if s:curbuffer.showheader
	" Index of first status will be 3 to match line numbers in timeline
	" display.
	let s:curbuffer.statuses = [0, 0, 0]
	let s:curbuffer.inreplyto = [0, 0, 0]

	" The extra stars at the end are for the syntax highlighter to
	" recognize the title. Then the syntax highlighter hides the stars by
	" coloring them the same as the background. It is a bad hack.
	call add(text, title.'*')
	call add(text, repeat('=', s:mbstrlen(title)).'*')
    else
	" Index of first status will be 1 to match line numbers in timeline
	" display.
	let s:curbuffer.statuses = [0]
	let s:curbuffer.inreplyto = [0]
    endif

    while 1
	let item = s:xml_get_nth(a:timeline, 'status', matchcount)
	if item == ""
	    break
	endif

	call add(s:curbuffer.statuses, s:xml_get_element(item, 'id'))
	call add(s:curbuffer.inreplyto, s:xml_get_element(item, 'in_reply_to_status_id'))

	let line = s:format_status_xml(item)
	call add(text, line)

	let matchcount += 1
    endwhile
    call s:twitter_wintext(text, "timeline")
    let s:curbuffer.buffer = text
endfunction

" Generic timeline retrieval function.
function! s:get_timeline(tline_name, username, page)
    let gotparam = 0

    if a:tline_name == "public"
	" No authentication is needed for public timeline.
	let login = ''
    else
	let login = s:get_twitvim_login()
	if login == ''
	    return -1
	endif
    endif

    " Twitter API allows you to specify a username for user_timeline to
    " retrieve another user's timeline.
    let user = a:username == '' ? '' : '/'.a:username

    let url_fname = (a:tline_name == "retweeted_to_me" || a:tline_name == "retweeted_by_me") ? a:tline_name.".xml" : a:tline_name == "friends" ? "home_timeline.xml" : a:tline_name == "replies" ? "mentions.xml" : a:tline_name."_timeline".user.".xml"

    " Support pagination.
    if a:page > 1
	let url_fname .= '?page='.a:page
	let gotparam = 1
    endif

    " Support count parameter in friends, user, mentions, and retweet timelines.
    if a:tline_name == 'friends' || a:tline_name == 'user' || a:tline_name == 'replies' || a:tline_name == 'retweeted_to_me' || a:tline_name == 'retweeted_by_me'
	let tcount = s:get_count()
	if tcount > 0
	    let url_fname .= (gotparam ? '&' : '?').'count='.tcount
	    let gotparam = 1
	endif
    endif

    let tl_name = a:tline_name == "replies" ? "mentions" : a:tline_name

    redraw
    echo "Sending" tl_name "timeline request to Twitter..."

    let url = s:get_api_root()."/statuses/".url_fname

    let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), {})

    if error != ''
	call s:errormsg("Error getting Twitter ".tl_name." timeline: ".error)
	return
    endif

    let error = s:xml_get_element(output, 'error')
    if error != ''
	call s:errormsg("Error getting Twitter ".tl_name." timeline: ".error)
	return
    endif

    call s:save_buffer()
    let s:curbuffer = {}
    call s:show_timeline_xml(output, a:tline_name, a:username, a:page)
    let s:curbuffer.buftype = a:tline_name
    let s:curbuffer.user = a:username
    let s:curbuffer.list = ''
    let s:curbuffer.page = a:page
    redraw

    let foruser = a:username == '' ? '' : ' for user '.a:username

    " Uppercase the first letter in the timeline name.
    echo substitute(tl_name, '^.', '\u&', '') "timeline updated".foruser."."
endfunction

" Retrieve a Twitter list timeline.
function! s:get_list_timeline(username, listname, page)
    let gotparam = 0

    let login = s:get_twitvim_login_noerror()
    " No login is no problem because the list statuses API is documented 
    " to not require authentication. However, you won't see tweets from
    " protected timelines.

    let user = a:username
    if user == ''
	let user = s:get_twitvim_username()
	if user == ''
	    call s:errormsg('Twitter login not set. Please specify a username.')
	    return -1
	endif
    endif

    let url = "/".user."/lists/".a:listname."/statuses.xml"

    " Support pagination.
    if a:page > 1
	let url .= '?page='.a:page
	let gotparam = 1
    endif

    " Support count parameter.
    let tcount = s:get_count()
    if tcount > 0
	let url .= (gotparam ? '&' : '?').'per_page='.tcount
	let gotparam = 1
    endif

    redraw
    echo "Sending list timeline request to Twitter..."

    let url = s:get_api_root().url

    let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), {})

    if error != ''
	call s:errormsg("Error getting Twitter list timeline: ".error)
	return
    endif

    let error = s:xml_get_element(output, 'error')
    if error != ''
	call s:errormsg("Error getting Twitter list timeline: ".error)
	return
    endif

    call s:save_buffer()
    let s:curbuffer = {}
    call s:show_timeline_xml(output, "list", user."/".a:listname, a:page)
    let s:curbuffer.buftype = "list"
    let s:curbuffer.user = user
    let s:curbuffer.list = a:listname
    let s:curbuffer.page = a:page
    redraw

    " Uppercase the first letter in the timeline name.
    echo "List timeline updated for ".user."/".a:listname
endfunction

" Show direct message sent or received by user. First argument should be 'sent'
" or 'received' depending on which timeline we are displaying.
function! s:show_dm_xml(sent_or_recv, timeline, page)
    let matchcount = 1
    let text = []

    "No status IDs in direct messages.
    let s:curbuffer.statuses = []
    let s:curbuffer.inreplyto = []

    let title = 'Direct messages '.a:sent_or_recv

    if a:page > 1
	let title .= ' (page '.a:page.')'
    endif

    let s:curbuffer.showheader = s:get_show_header()
    if s:curbuffer.showheader
	" Index of first dmid will be 3 to match line numbers in timeline
	" display.
	let s:curbuffer.dmids = [0, 0, 0]

	" The extra stars at the end are for the syntax highlighter to
	" recognize the title. Then the syntax highlighter hides the stars by
	" coloring them the same as the background. It is a bad hack.
	call add(text, title.'*')
	call add(text, repeat('=', s:mbstrlen(title)).'*')
    else
	" Index of first dmid will be 1 to match line numbers in timeline
	" display.
	let s:curbuffer.dmids = [0]
    endif

    while 1
	let item = s:xml_get_nth(a:timeline, 'direct_message', matchcount)
	if item == ""
	    break
	endif

	call add(s:curbuffer.dmids, s:xml_get_element(item, 'id'))

	let user = s:xml_get_element(item, a:sent_or_recv == 'sent' ? 'recipient_screen_name' : 'sender_screen_name')
	let mesg = s:xml_get_element(item, 'text')
	let date = s:time_filter(s:xml_get_element(item, 'created_at'))

	call add(text, user.": ".s:convert_entity(mesg).' |'.date.'|')

	let matchcount += 1
    endwhile
    call s:twitter_wintext(text, "timeline")
    let s:curbuffer.buffer = text
endfunction

" Get direct messages sent to or received by user.
function! s:Direct_Messages(mode, page)
    let sent = (a:mode == "dmsent")
    let s_or_r = (sent ? "sent" : "received")

    let login = s:get_twitvim_login()
    if login == ''
	return -1
    endif

    " Support pagination.
    let pagearg = ''
    if a:page > 1
	let pagearg = '?page='.a:page
    endif

    redraw
    echo "Sending direct messages ".s_or_r." timeline request to Twitter..."

    let url = s:get_api_root()."/direct_messages".(sent ? "/sent" : "").".xml".pagearg

    let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), {})

    if error != ''
	call s:errormsg("Error getting Twitter direct messages ".s_or_r." timeline: ".error)
	return
    endif

    call s:save_buffer()
    let s:curbuffer = {}
    call s:show_dm_xml(s_or_r, output, a:page)
    let s:curbuffer.buftype = a:mode
    let s:curbuffer.user = ''
    let s:curbuffer.list = ''
    let s:curbuffer.page = a:page
    redraw
    echo "Direct messages ".s_or_r." timeline updated."
endfunction

" Function to load a timeline from the given parameters. For use by refresh and
" next/prev pagination commands.
function! s:load_timeline(buftype, user, list, page)
    if a:buftype == "public" || a:buftype == "friends" || a:buftype == "user" || a:buftype == "replies" || a:buftype == "retweeted_by_me" || a:buftype == "retweeted_to_me"
	call s:get_timeline(a:buftype, a:user, a:page)
    elseif a:buftype == "list"
	call s:get_list_timeline(a:user, a:list, a:page)
    elseif a:buftype == "dmsent" || a:buftype == "dmrecv"
	call s:Direct_Messages(a:buftype, a:page)
    elseif a:buftype == "search"
	call s:get_summize(a:user, a:page)
    endif
endfunction

" Refresh the timeline buffer.
function! s:RefreshTimeline()
    if s:curbuffer != {}
	call s:load_timeline(s:curbuffer.buftype, s:curbuffer.user, s:curbuffer.list, s:curbuffer.page)
    else
	call s:warnmsg("No timeline buffer to refresh.")
    endif
endfunction

" Go to next page in timeline.
function! s:NextPageTimeline()
    if s:curbuffer != {}
	call s:load_timeline(s:curbuffer.buftype, s:curbuffer.user, s:curbuffer.list, s:curbuffer.page + 1)
    else
	call s:warnmsg("No timeline buffer.")
    endif
endfunction

" Go to previous page in timeline.
function! s:PrevPageTimeline()
    if s:curbuffer != {}
	if s:curbuffer.page <= 1
	    call s:warnmsg("Timeline is already on first page.")
	else
	    call s:load_timeline(s:curbuffer.buftype, s:curbuffer.user, s:curbuffer.list, s:curbuffer.page - 1)
	endif
    else
	call s:warnmsg("No timeline buffer.")
    endif
endfunction

" Get a Twitter list. Need to do a little fiddling because the 
" username argument is optional.
function! s:DoList(page, arg1, ...)
    let user = ''
    let list = a:arg1
    if a:0 > 0
	let user = a:arg1
	let list = a:1
    endif
    call s:get_list_timeline(user, list, a:page)
endfunction

if !exists(":PublicTwitter")
    command PublicTwitter :call <SID>get_timeline("public", '', 1)
endif
if !exists(":FriendsTwitter")
    command -count=1 FriendsTwitter :call <SID>get_timeline("friends", '', <count>)
endif
if !exists(":UserTwitter")
    command -range=1 -nargs=? UserTwitter :call <SID>get_timeline("user", <q-args>, <count>)
endif
if !exists(":MentionsTwitter")
    command -count=1 MentionsTwitter :call <SID>get_timeline("replies", '', <count>)
endif
if !exists(":RepliesTwitter")
    command -count=1 RepliesTwitter :call <SID>get_timeline("replies", '', <count>)
endif
if !exists(":DMTwitter")
    command -count=1 DMTwitter :call <SID>Direct_Messages("dmrecv", <count>)
endif
if !exists(":DMSentTwitter")
    command -count=1 DMSentTwitter :call <SID>Direct_Messages("dmsent", <count>)
endif
if !exists(":ListTwitter")
    command -range=1 -nargs=+ ListTwitter :call <SID>DoList(<count>, <f-args>)
endif
if !exists(":RetweetedByMeTwitter")
    command -count=1 RetweetedByMeTwitter :call <SID>get_timeline("retweeted_by_me", '', <count>)
endif
if !exists(":RetweetedToMeTwitter")
    command -count=1 RetweetedToMeTwitter :call <SID>get_timeline("retweeted_to_me", '', <count>)
endif

nnoremenu Plugin.TwitVim.-Sep1- :
nnoremenu Plugin.TwitVim.&Friends\ Timeline :call <SID>get_timeline("friends", '', 1)<cr>
nnoremenu Plugin.TwitVim.&User\ Timeline :call <SID>get_timeline("user", '', 1)<cr>
nnoremenu Plugin.TwitVim.&Mentions\ Timeline :call <SID>get_timeline("replies", '', 1)<cr>
nnoremenu Plugin.TwitVim.&Direct\ Messages :call <SID>Direct_Messages("dmrecv", 1)<cr>
nnoremenu Plugin.TwitVim.Direct\ Messages\ &Sent :call <SID>Direct_Messages("dmsent", 1)<cr>
nnoremenu Plugin.TwitVim.&Public\ Timeline :call <SID>get_timeline("public", '', 1)<cr>

nnoremenu Plugin.TwitVim.Retweeted\ &By\ Me :call <SID>get_timeline("retweeted_by_me", '', 1)<cr>
nnoremenu Plugin.TwitVim.Retweeted\ &To\ Me :call <SID>get_timeline("retweeted_to_me", '', 1)<cr>

if !exists(":RefreshTwitter")
    command RefreshTwitter :call <SID>RefreshTimeline()
endif
if !exists(":NextTwitter")
    command NextTwitter :call <SID>NextPageTimeline()
endif
if !exists(":PreviousTwitter")
    command PreviousTwitter :call <SID>PrevPageTimeline()
endif

if !exists(":SetLoginTwitter")
    command SetLoginTwitter :call <SID>prompt_twitvim_login()
endif
if !exists(":ResetLoginTwitter")
    command ResetLoginTwitter :call <SID>reset_twitvim_login()
endif

nnoremenu Plugin.TwitVim.-Sep2- :
nnoremenu Plugin.TwitVim.Set\ Twitter\ Login :call <SID>prompt_twitvim_login()<cr>
nnoremenu Plugin.TwitVim.Reset\ Twitter\ Login :call <SID>reset_twitvim_login()<cr>


" Send a direct message.
function! s:do_send_dm(user, mesg)
    let login = s:get_twitvim_login()
    if login == ''
	return -1
    endif

    let mesg = a:mesg

    " Remove trailing newline. You see that when you visual-select an entire
    " line. Don't let it count towards the message length.
    let mesg = substitute(mesg, '\n$', '', "")

    " Convert internal newlines to spaces.
    let mesg = substitute(mesg, '\n', ' ', "g")

    let mesglen = s:mbstrlen(mesg)

    " Check message length. Note that the message length should be checked
    " before URL-encoding the special characters because URL-encoding increases
    " the string length.
    if mesglen > s:char_limit
	call s:warnmsg("Your message has ".(mesglen - s:char_limit)." too many characters. It was not sent.")
    elseif mesglen < 1
	call s:warnmsg("Your message was empty. It was not sent.")
    else
	redraw
	echo "Sending message to ".a:user."..."

	let url = s:get_api_root()."/direct_messages/new.xml?source=twitvim"
	let parms = { "user" : a:user, "text" : mesg }

	let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), parms)

	if error != ''
	    call s:errormsg("Error sending your message: ".error)
	else
	    redraw
	    echo "Your message was sent to ".a:user.". You used ".mesglen." characters."
	endif
    endif
endfunction

" Send a direct message. Prompt user for message if not given.
function! s:send_dm(user, mesg)
    if a:user == ""
	call s:warnmsg("No recipient specified for direct message.")
	return
    endif

    let mesg = a:mesg
    if mesg == ""
	call inputsave()
	let mesg = input("DM ".a:user.": ")
	call inputrestore()
    endif

    if mesg == ""
	call s:warnmsg("Your message was empty. It was not sent.")
	return
    endif

    call s:do_send_dm(a:user, mesg)
endfunction

if !exists(":SendDMTwitter")
    command -nargs=1 SendDMTwitter :call <SID>send_dm(<q-args>, '')
endif

" Call Twitter API to get rate limit information.
function! s:get_rate_limit()
    let login = s:get_twitvim_login()
    if login == ''
	return -1
    endif

    redraw
    echo "Querying Twitter for rate limit information..."

    let url = s:get_api_root()."/account/rate_limit_status.xml"
    let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), {})
    if error != ''
	call s:errormsg("Error getting rate limit info: ".error)
	return
    endif

    let error = s:xml_get_element(output, 'error')
    if error != ''
	call s:errormsg("Error getting rate limit info: ".error)
	return
    endif

    let remaining = s:xml_get_element(output, 'remaining-hits')
    let resettime = s:time_filter(s:xml_get_element(output, 'reset-time'))
    let limit = s:xml_get_element(output, 'hourly-limit')

    redraw
    echo "Rate limit: ".limit." Remaining: ".remaining." Reset at: ".resettime
endfunction

if !exists(":RateLimitTwitter")
    command RateLimitTwitter :call <SID>get_rate_limit()
endif

" Set location field on Twitter profile.
function! s:set_location(loc)
    let login = s:get_twitvim_login()
    if login == ''
	return -1
    endif

    redraw
    echo "Setting location on Twitter profile..."

    let url = s:get_api_root()."/account/update_location.xml"
    let parms = { 'location' : a:loc }

    let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), parms)
    if error != ''
	call s:errormsg("Error setting location: ".error)
	return
    endif

    let error = s:xml_get_element(output, 'error')
    if error != ''
	call s:errormsg("Error setting location: ".error)
	return
    endif

    redraw
    echo "Location: ".s:xml_get_element(output, 'location')
endfunction

if !exists(":LocationTwitter")
    command -nargs=+ LocationTwitter :call <SID>set_location(<q-args>)
endif

let s:user_winname = "TwitterUserInfo_".localtime()

" Process/format the user information.
function! s:format_user_info(output)
    let text = []
    let output = a:output

    let name = s:xml_get_element(output, 'name')
    let screen = s:xml_get_element(output, 'screen_name')
    call add(text, 'Name: '.screen.' ('.name.')')

    call add(text, 'Location: '.s:xml_get_element(output, 'location'))
    call add(text, 'Website: '.s:xml_get_element(output, 'url'))
    call add(text, 'Bio: '.s:xml_get_element(output, 'description'))
    call add(text, '')
    call add(text, 'Following: '.s:xml_get_element(output, 'friends_count'))
    call add(text, 'Followers: '.s:xml_get_element(output, 'followers_count'))
    call add(text, 'Updates: '.s:xml_get_element(output, 'statuses_count'))
    call add(text, '')

    let status = s:xml_get_element(output, 'text')
    let pubdate = s:time_filter(s:xml_get_element(output, 'created_at'))
    call add(text, 'Status: '.s:convert_entity(status).' |'.pubdate.'|')
    return text
endfunction

" Call Twitter API to get user's info.
function! s:get_user_info(username)
    let login = s:get_twitvim_login()
    if login == ''
	return -1
    endif

    if a:username == ''
	call s:errormsg("Please specify a user name to retrieve info on.")
	return
    endif

    redraw
    echo "Querying Twitter for user information..."

    let url = s:get_api_root()."/users/show/".a:username.".xml"
    let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), {})
    if error != ''
	call s:errormsg("Error getting user info: ".error)
	return
    endif

    let error = s:xml_get_element(output, 'error')
    if error != ''
	call s:errormsg("Error getting user info: ".error)
	return
    endif

    call s:twitter_wintext(s:format_user_info(output), "userinfo")

    redraw
    echo "User information retrieved."
endfunction

if !exists(":ProfileTwitter")
    command -nargs=1 ProfileTwitter :call <SID>get_user_info(<q-args>)
endif


" Call Tweetburner API to shorten a URL.
function! s:call_tweetburner(url)
    redraw
    echo "Sending request to Tweetburner..."

    let [error, output] = s:run_curl('http://tweetburner.com/links', '', s:get_proxy(), s:get_proxy_login(), {'link[url]' : a:url})

    if error != ''
	call s:errormsg("Error calling Tweetburner API: ".error)
	return ""
    else
	redraw
	echo "Received response from Tweetburner."
	return output
    endif
endfunction

" Call SnipURL API to shorten a URL.
function! s:call_snipurl(url)
    redraw
    echo "Sending request to SnipURL..."

    let url = 'http://snipr.com/site/snip?r=simple&link='.s:url_encode(a:url)

    let [error, output] = s:run_curl(url, '', s:get_proxy(), s:get_proxy_login(), {})

    if error != ''
	call s:errormsg("Error calling SnipURL API: ".error)
	return ""
    else
	redraw
	echo "Received response from SnipURL."
	" Get rid of extraneous newline at the beginning of SnipURL's output.
	return substitute(output, '^\n', '', '')
    endif
endfunction

" Call Metamark API to shorten a URL.
function! s:call_metamark(url)
    redraw
    echo "Sending request to Metamark..."

    let [error, output] = s:run_curl('http://metamark.net/api/rest/simple', '', s:get_proxy(), s:get_proxy_login(), {'long_url' : a:url})

    if error != ''
	call s:errormsg("Error calling Metamark API: ".error)
	return ""
    else
	redraw
	echo "Received response from Metamark."
	return output
    endif
endfunction

" Call TinyURL API to shorten a URL.
function! s:call_tinyurl(url)
    redraw
    echo "Sending request to TinyURL..."

    let url = 'http://tinyurl.com/api-create.php?url='.a:url
    let [error, output] = s:run_curl(url, '', s:get_proxy(), s:get_proxy_login(), {})

    if error != ''
	call s:errormsg("Error calling TinyURL API: ".error)
	return ""
    else
	redraw
	echo "Received response from TinyURL."
	return output
    endif
endfunction

" Get bit.ly username and api key if configured by the user. Otherwise, use a
" default username and api key.
function! s:get_bitly_key()
    if exists('g:twitvim_bitly_user') && exists('g:twitvim_bitly_key')
	return [ g:twitvim_bitly_user, g:twitvim_bitly_key ]
    endif
    return [ 'twitvim', 'R_a53414d2f36a90c3e189299c967e6efc' ]
endfunction

" Call bit.ly API to shorten a URL.
function! s:call_bitly(url)
    let [ user, key ] = s:get_bitly_key()

    redraw
    echo "Sending request to bit.ly..."

    let url = 'http://api.bit.ly/shorten?version=2.0.1'
    let url .= '&longUrl='.s:url_encode(a:url)
    let url .= '&login='.user
    let url .= '&apiKey='.key.'&format=xml&history=1'
    let [error, output] = s:run_curl(url, '', s:get_proxy(), s:get_proxy_login(), {})

    if error != ''
	call s:errormsg("Error calling bit.ly API: ".error)
	return ""
    endif

    let status = s:xml_get_element(output, 'statusCode')
    if status != 'OK'
	let errorcode = s:xml_get_element(output, 'errorCode')
	let errormsg = s:xml_get_element(output, 'errorMessage')
	if errorcode == 0
	    " For reasons unknown, bit.ly sometimes return two error codes and
	    " the first one is 0.
	    let errorcode = s:xml_get_nth(output, 'errorCode', 2)
	    let errormsg = s:xml_get_nth(output, 'errorMessage', 2)
	endif
	call s:errormsg("Error from bit.ly: ".errorcode." ".errormsg)
	return ""
    endif

    let shorturl = s:xml_get_element(output, 'shortUrl')
    redraw
    echo "Received response from bit.ly."
    return shorturl
endfunction

" Call is.gd API to shorten a URL.
function! s:call_isgd(url)
    redraw
    echo "Sending request to is.gd..."

    let url = 'http://is.gd/api.php?longurl='.s:url_encode(a:url)
    let [error, output] = s:run_curl(url, '', s:get_proxy(), s:get_proxy_login(), {})

    if error != ''
	call s:errormsg("Error calling is.gd API: ".error)
	return ""
    else
	redraw
	echo "Received response from is.gd."
	return output
    endif
endfunction


" Get urlBorg API key if configured by the user. Otherwise, use a default API
" key.
function! s:get_urlborg_key()
    return exists('g:twitvim_urlborg_key') ? g:twitvim_urlborg_key : '26361-80ab'
endfunction

" Call urlBorg API to shorten a URL.
function! s:call_urlborg(url)
    let key = s:get_urlborg_key()
    redraw
    echo "Sending request to urlBorg..."

    let url = 'http://urlborg.com/api/'.key.'/create_or_reuse/'.s:url_encode(a:url)
    let [error, output] = s:run_curl(url, '', s:get_proxy(), s:get_proxy_login(), {})

    if error != ''
	call s:errormsg("Error calling urlBorg API: ".error)
	return ""
    else
	if output !~ '\c^http'
	    call s:errormsg("urlBorg error: ".output)
	    return ""
	endif

	redraw
	echo "Received response from urlBorg."
	return output
    endif
endfunction


" Get tr.im login info if configured by the user.
function! s:get_trim_login()
    return exists('g:twitvim_trim_login') ? g:twitvim_trim_login : ''
endfunction

" Call tr.im API to shorten a URL.
function! s:call_trim(url)
    let login = s:get_trim_login()

    redraw
    echo "Sending request to tr.im..."

    let url = 'http://tr.im/api/trim_url.xml?url='.s:url_encode(a:url)

    let [error, output] = s:run_curl(url, login, s:get_proxy(), s:get_proxy_login(), {})

    if error != ''
	call s:errormsg("Error calling tr.im API: ".error)
	return ""
    endif

    let statusattr = s:xml_get_attr(output, 'status')

    let trimmsg = statusattr['code'].' '.statusattr['message']

    if statusattr['result'] == "OK"
	return s:xml_get_element(output, 'url')
    elseif statusattr['result'] == "ERROR"
	call s:errormsg("tr.im error: ".trimmsg)
	return ""
    else
	call s:errormsg("Unknown result from tr.im: ".trimmsg)
	return ""
    endif
endfunction

" Get Cligs API key if configured by the user.
function! s:get_cligs_key()
    return exists('g:twitvim_cligs_key') ? g:twitvim_cligs_key : ''
endfunction

" Call Cligs API to shorten a URL.
function! s:call_cligs(url)
    let url = 'http://cli.gs/api/v1/cligs/create?appid=twitvim&url='.s:url_encode(a:url)

    let key = s:get_cligs_key()
    if key != ''
	let url .= '&key='.key
    endif

    redraw
    echo "Sending request to Cligs..."

    let [error, output] = s:run_curl(url, '', s:get_proxy(), s:get_proxy_login(), {})
    if error != ''
	call s:errormsg("Error calling Cligs API: ".error)
	return ""
    endif

    redraw
    echo "Received response from Cligs."
    return output
endfunction

" Call Zi.ma API to shorten a URL.
function! s:call_zima(url)
    let url = "http://zi.ma/?module=ShortURL&file=Add&mode=API&url=".s:url_encode(a:url)

    redraw
    echo "Sending request to Zi.ma..."

    let [error, output] = s:run_curl(url, '', s:get_proxy(), s:get_proxy_login(), {})
    if error != ''
	call s:errormsg("Error calling Zi.ma API: ".error)
	return ""
    endif

    let error = s:xml_get_element(output, 'h3')
    if error != ''
	call s:errormsg("Error from Zi.ma: ".error)
	return ""
    endif

    redraw
    echo "Received response from Zi.ma."
    return output
endfunction

" Invoke URL shortening service to shorten a URL and insert it at the current
" position in the current buffer.
function! s:GetShortURL(tweetmode, url, shortfn)
    let url = a:url

    " Prompt the user to enter a URL if not provided on :Tweetburner command
    " line.
    if url == ""
	call inputsave()
	let url = input("URL to shorten: ")
	call inputrestore()
    endif

    if url == ""
	call s:warnmsg("No URL provided.")
	return
    endif

    let shorturl = call(function("s:".a:shortfn), [url])
    if shorturl != ""
	if a:tweetmode == "cmdline"
	    call s:CmdLine_Twitter(shorturl." ", 0)
	elseif a:tweetmode == "append"
	    execute "normal! a".shorturl."\<esc>"
	else
	    execute "normal! i".shorturl." \<esc>"
	endif
    endif
endfunction

if !exists(":Tweetburner")
    command -nargs=? Tweetburner :call <SID>GetShortURL("insert", <q-args>, "call_tweetburner")
endif
if !exists(":ATweetburner")
    command -nargs=? ATweetburner :call <SID>GetShortURL("append", <q-args>, "call_tweetburner")
endif
if !exists(":PTweetburner")
    command -nargs=? PTweetburner :call <SID>GetShortURL("cmdline", <q-args>, "call_tweetburner")
endif

if !exists(":Snipurl")
    command -nargs=? Snipurl :call <SID>GetShortURL("insert", <q-args>, "call_snipurl")
endif
if !exists(":ASnipurl")
    command -nargs=? ASnipurl :call <SID>GetShortURL("append", <q-args>, "call_snipurl")
endif
if !exists(":PSnipurl")
    command -nargs=? PSnipurl :call <SID>GetShortURL("cmdline", <q-args>, "call_snipurl")
endif

if !exists(":Metamark")
    command -nargs=? Metamark :call <SID>GetShortURL("insert", <q-args>, "call_metamark")
endif
if !exists(":AMetamark")
    command -nargs=? AMetamark :call <SID>GetShortURL("append", <q-args>, "call_metamark")
endif
if !exists(":PMetamark")
    command -nargs=? PMetamark :call <SID>GetShortURL("cmdline", <q-args>, "call_metamark")
endif

if !exists(":TinyURL")
    command -nargs=? TinyURL :call <SID>GetShortURL("insert", <q-args>, "call_tinyurl")
endif
if !exists(":ATinyURL")
    command -nargs=? ATinyURL :call <SID>GetShortURL("append", <q-args>, "call_tinyurl")
endif
if !exists(":PTinyURL")
    command -nargs=? PTinyURL :call <SID>GetShortURL("cmdline", <q-args>, "call_tinyurl")
endif

if !exists(":BitLy")
    command -nargs=? BitLy :call <SID>GetShortURL("insert", <q-args>, "call_bitly")
endif
if !exists(":ABitLy")
    command -nargs=? ABitLy :call <SID>GetShortURL("append", <q-args>, "call_bitly")
endif
if !exists(":PBitLy")
    command -nargs=? PBitLy :call <SID>GetShortURL("cmdline", <q-args>, "call_bitly")
endif

if !exists(":IsGd")
    command -nargs=? IsGd :call <SID>GetShortURL("insert", <q-args>, "call_isgd")
endif
if !exists(":AIsGd")
    command -nargs=? AIsGd :call <SID>GetShortURL("append", <q-args>, "call_isgd")
endif
if !exists(":PIsGd")
    command -nargs=? PIsGd :call <SID>GetShortURL("cmdline", <q-args>, "call_isgd")
endif

if !exists(":UrlBorg")
    command -nargs=? UrlBorg :call <SID>GetShortURL("insert", <q-args>, "call_urlborg")
endif
if !exists(":AUrlBorg")
    command -nargs=? AUrlBorg :call <SID>GetShortURL("append", <q-args>, "call_urlborg")
endif
if !exists(":PUrlBorg")
    command -nargs=? PUrlBorg :call <SID>GetShortURL("cmdline", <q-args>, "call_urlborg")
endif

if !exists(":Trim")
    command -nargs=? Trim :call <SID>GetShortURL("insert", <q-args>, "call_trim")
endif
if !exists(":ATrim")
    command -nargs=? ATrim :call <SID>GetShortURL("append", <q-args>, "call_trim")
endif
if !exists(":PTrim")
    command -nargs=? PTrim :call <SID>GetShortURL("cmdline", <q-args>, "call_trim")
endif

if !exists(":Cligs")
    command -nargs=? Cligs :call <SID>GetShortURL("insert", <q-args>, "call_cligs")
endif
if !exists(":ACligs")
    command -nargs=? ACligs :call <SID>GetShortURL("append", <q-args>, "call_cligs")
endif
if !exists(":PCligs")
    command -nargs=? PCligs :call <SID>GetShortURL("cmdline", <q-args>, "call_cligs")
endif

if !exists(":Zima")
    command -nargs=? Zima :call <SID>GetShortURL("insert", <q-args>, "call_zima")
endif
if !exists(":AZima")
    command -nargs=? AZima :call <SID>GetShortURL("append", <q-args>, "call_zima")
endif
if !exists(":PZima")
    command -nargs=? PZima :call <SID>GetShortURL("cmdline", <q-args>, "call_zima")
endif

" Parse and format search results from Twitter Search API.
function! s:show_summize(searchres, page)
    let text = []
    let matchcount = 1

    let s:curbuffer.dmids = []

    let channel = s:xml_remove_elements(a:searchres, 'entry')
    let title = s:xml_get_element(channel, 'title')

    if a:page > 1
	let title .= ' (page '.a:page.')'
    endif

    let s:curbuffer.showheader = s:get_show_header()
    if s:curbuffer.showheader
	" Index of first status will be 3 to match line numbers in timeline
	" display.
	let s:curbuffer.statuses = [0, 0, 0]
	let s:curbuffer.inreplyto = [0, 0, 0]

	" The extra stars at the end are for the syntax highlighter to
	" recognize the title. Then the syntax highlighter hides the stars by
	" coloring them the same as the background. It is a bad hack.
	call add(text, title.'*')
	call add(text, repeat('=', strlen(title)).'*')
    else
	" Index of first status will be 1 to match line numbers in timeline
	" display.
	let s:curbuffer.statuses = [0]
	let s:curbuffer.inreplyto = [0]
    endif

    while 1
	let item = s:xml_get_nth(a:searchres, 'entry', matchcount)
	if item == ""
	    break
	endif

	let title = s:xml_get_element(item, 'title')
	let pubdate = s:time_filter(s:xml_get_element(item, 'updated'))
	let sender = substitute(s:xml_get_element(item, 'uri'), 'http://twitter.com/', '', '')

	" Parse and save the status ID.
	let status = substitute(s:xml_get_element(item, 'id'), '^.*:', '', '')
	call add(s:curbuffer.statuses, status)

	call add(text, sender.": ".s:convert_entity(title).' |'.pubdate.'|')

	let matchcount += 1
    endwhile
    call s:twitter_wintext(text, "timeline")
    let s:curbuffer.buffer = text
endfunction

" Query Twitter Search API and retrieve results
function! s:get_summize(query, page)
    redraw
    echo "Sending search request to Twitter Search..."

    let param = ''

    " Support pagination.
    if a:page > 1
	let param .= 'page='.a:page.'&'
    endif

    " Support count parameter in search results.
    let tcount = s:get_count()
    if tcount > 0
	let param .= 'rpp='.tcount.'&'
    endif

    let url = 'http://search.twitter.com/search.atom?'.param.'q='.s:url_encode(a:query)
    let [error, output] = s:run_curl(url, '', s:get_proxy(), s:get_proxy_login(), {})

    if error != ''
	call s:errormsg("Error querying Twitter Search: ".error)
	return
    endif

    call s:save_buffer()
    let s:curbuffer = {}
    call s:show_summize(output, a:page)
    let s:curbuffer.buftype = "search"

    " Stick the query in here to differentiate between sets of search results.
    let s:curbuffer.user = a:query

    let s:curbuffer.list = ''
    let s:curbuffer.page = a:page
    redraw
    echo "Received search results from Twitter Search."
endfunction

" Prompt user for Twitter Search query string if not entered on command line.
function! s:Summize(query, page)
    let query = a:query

    " Prompt the user to enter a query if not provided on :SearchTwitter
    " command line.
    if query == ""
	call inputsave()
	let query = input("Search Twitter: ")
	call inputrestore()
    endif

    if query == ""
	call s:warnmsg("No query provided for Twitter Search.")
	return
    endif

    call s:get_summize(query, a:page)
endfunction

if !exists(":Summize")
    command -range=1 -nargs=? Summize :call <SID>Summize(<q-args>, <count>)
endif
if !exists(":SearchTwitter")
    command -range=1 -nargs=? SearchTwitter :call <SID>Summize(<q-args>, <count>)
endif

let &cpo = s:save_cpo
finish

" vim:set tw=0:
