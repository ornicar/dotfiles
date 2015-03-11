#!/bin/bash -x
output="/home/vhosts/classic/public_html/linux-adaway/hostfile2blockad.txt"
URL[0]="http://winhelp2002.mvps.org/hosts.txt"
URL[1]="http://hosts-file.net/ad_servers.asp"
URL[2]="http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
URL[3]="https://adaway.org/hosts.txt"
URL[4]="http://someonewhocares.org/hosts/hosts"
CURL="curl --max-filesize 1000000 "
echo $CURL
TMP=$(mktemp)
RT=$(mktemp)
for u in "${URL[@]}"
do
	truncate -s0 $TMP
	${CURL} "${u}" --output $TMP > /dev/null 2>&1
	cat $TMP |egrep "^127\.0\.0\.1|^0\.0\.0\.0 " |awk '{print $2}'|egrep -o '([a-zA-Z0-9]|[0-9_-.]){2,}'|uniq |sort | cat - >> $RT		
done
cat $RT |sort|uniq|awk '{print "127.0.0.1  ",$1}' > $output
rm -f $RT
rm -f $TMP
