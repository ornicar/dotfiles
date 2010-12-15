################################################################################
#
# notify.pl - use libnotify's notify-send to work like growl
#
# By Erik Hollensbe <erik@hollensbe.org>
#
# usage:
#
# See the callback map on line 37? Those are the defined message types.
#
# Set those in your "notify_types" separated by a space:
#
# /set notify_types PRIVATE HILIGHT
#
# Will give you notify pops on private messages and highlights (this is the default).
#
################################################################################

use strict;
use warnings;

use Irssi;
use Net::DBus;
use CGI;

my $VERSION = "0.1";

my %IRSSI = (
    authors	=> 'Erik Hollensbe',
    contact	=> 'erik@hollensbe.org',
    name	=> 'Notify',
    description	=> 'uses notify-send to work like growl.pl',
    license	=> 'Public Domain',
    url		=> 'http://erik.hollensbe.org/',
    changed	=> '$Date: 2004/05/11 06:53:42 $',
);

#
# The callback map is used by the autoloader to determine where to send
# the signal, which in turn will launch the notifier.
#

our %CALLBACK_MAP = (
    PRIVATE  => \&event_msg,
    HILIGHT  => \&event_print_text,
    PUBLIC   => \&event_msg,
    NOTICE   => \&event_msg,

    CTCP     => \&event_ctcp,

    CHANMODE => \&event_channel_mode,
    USERMODE => \&event_user_mode,

    KICK     => \&event_kick,
    BAN      => \&event_ban,
    
    SNOTICE  => \&event_server_msg,
);

sub get_notify_types { 
    map { uc $_ } split(/\s+/, Irssi::settings_get_str("notify_types"));
}

sub AUTOLOAD {
    our $AUTOLOAD;
    my $al = $AUTOLOAD;

    # normalize $al to be uppercase and contain the subroutine name only
    ($al) = $al =~ /([^:]+)$/;
    $al = uc $al;

    if (scalar grep /^(ALL|$al)$/, get_notify_types) { 
        $CALLBACK_MAP{$al}->(@_); 
    }
}

sub launch_notifier {
    my ($title, $message) = @_;

    # taken without remorse from Desktop::Notify
    my $object = Net::DBus->session
        ->get_service('org.freedesktop.Notifications')
        ->get_object('/org/freedesktop/Notifications', 'org.freedesktop.Notifications');
    $object->Notify('irssi', 0, '', $title, CGI::escapeHTML($message), [], { }, Irssi::settings_get_str("notify_duration"));
}

#
# Our callback events
#

sub event_print_text {
    my ($dest, $text, $stripped) = @_;

    if ($dest->{level} & MSGLEVEL_HILIGHT) {
        launch_notifier($dest->{target}, $stripped);
    }
}

sub event_msg {
    my ($server, $data, $nick, $host, $channel) = @_;

    my $title = $nick;

    $title .= " \@ $channel" if $channel;

    launch_notifier($title, $data);
}

sub event_ctcp {
    my ($server, $data, $nick, $host, $target) = @_;

    my $cmd;

    ($cmd, $data) = split(/\s+/, $data, 2);

    my $title = "CTCP $cmd from $nick to $target";

    launch_notifier($title, $data);
}

sub event_channel_mode { 
    my ($channel, $setby) = @_;

    my $title = $channel->{name}. ": Channel Mode Changed";
    my $data  = "+".$channel->{mode}. " set by $setby";

    launch_notifier($title, $data);
}

sub event_user_mode { 
    my ($server, $old) = @_;

    my $title = "Mode Changed: ".$server->{nick}."\@".$server->{address};
    my $data  = "From +".$old." to +".$server->{usermode};

    launch_notifier($title, $data);
}

sub event_kick {
    my ($server, $channel, $nick, $kicker, $address, $reason) = @_;

    my $title = "KICK: $nick from $channel by $kicker";

    launch_notifier($title, $reason);
}

sub event_ban {
    my ($channel, $ban, $setby) = @_;

    my $type;

    if ($setby) {
        # we have a removal
        $type = "removal";
    } else { 
        $type = "add";
    }

    my $title = "BAN $type on ".$channel->{name}." by ".$ban->{setby};
    my $data = $ban->{ban};

    launch_notifier($title, $data);
}

sub event_server_msg {
    my ($server, $target, $msg, $target_type) = @_;

    my $title = "Server notice: ".$server->{address}. "to $target";

    launch_notifier($title, $msg);
}

Irssi::settings_add_str("notify", "notify_types", "PRIVATE HILIGHT");
Irssi::settings_add_str("notify", "notify_duration", "5000");

Irssi::signal_add_last("print text", "hilight");
Irssi::signal_add_last("message private", "private");
Irssi::signal_add_last("message public", "public");
Irssi::signal_add_last("message irc notice", "notice");
Irssi::signal_add_last("ctcp msg", "ctcp");
Irssi::signal_add_last("channel mode changed", "chanmode");
Irssi::signal_add_last("user mode changed", "usermode");
Irssi::signal_add_last("message kick", "kick");
Irssi::signal_add_last("ban new", "ban");
Irssi::signal_add_last("ban remove", "ban");
Irssi::signal_add_last("server sendmsg", "snotice");
