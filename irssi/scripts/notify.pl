## Modified notify script.. edited for Awesome window manager
## Put me in ~/.irssi/scripts/autorun
##

use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = "0.02";
%IRSSI = (
    authors     => 'Donald Ephraim Curtis',
    contact     => 'dcurtis@cs.uiowa.edu',
    name        => 'notify.pl',
    description => 'notify Awesome WM of irssi message',
    license     => 'GNU General Public License',
);

sub notify {
    my ($title, $text) = @_;

    my %replacements = (
        '<' => '<',
        '>' => '>',
        '&' => '&',
        '\"' => '"',
        '`' => '', # added for security purposes
    );

    # lazy way of constructing the regexp - I've done enough typing already!
    my $replacement_string = join '', keys %replacements;


    $title =~ s/([\Q$replacement_string\E])/$replacements{$1}/g;
    $text =~ s/([\Q$replacement_string\E])/$replacements{$1}/g;

    system("notify-send -t 7500 \"<span color='#ffffff'>".$title."</span>\""." \"".$text."\"");
}


sub highlight {
    my ($dest, $msg, $stripped) = @_;

    my $window = Irssi::active_win();

    if (($dest->{level} & MSGLEVEL_HILIGHT) && ($dest->{level} & MSGLEVEL_PUBLIC)) {
        notify($dest->{target}, $stripped);
    }

}

sub query {
    my ($server, $msg, $nick, $addr) = @_;

    my $window = Irssi::active_win();

    my $itemwindow = $server->window_find_item($nick);
    if ($window->{refnum} != $itemwindow->{refnum}) {
        notify($nick, $msg);
    }
}

Irssi::signal_add('print text', 'highlight');
Irssi::signal_add('message private', 'query');
