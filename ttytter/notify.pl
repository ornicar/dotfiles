sub notifier_libnotifyperl {
    my $class = shift;
    my $text = shift;
    my $ref = shift; # not used in this version

    my $escaped = `echo \"TTYtter: $class - $text\" | iconv -c -f utf-8 -t ISO-8859-1`;

    `ratpoison -c \"echo $escaped\"`;

    return 1;
}
1;
