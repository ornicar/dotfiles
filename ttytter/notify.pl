sub notifier_ratpoison {
    my $class = shift;
    my $text = shift;
    my $ref = shift; # not used in this version

	if (!defined($class) || !defined($ratpoison_path)) {
		# we are being asked to initialize
		$ratpoison_path = &wherecheck("trying to find ratpoison",
			"ratpoison",
            "ratpoison must be installed to use this notifier\n");
		if (!defined($class)) {
			$class = 'TTYtter';
			$text = 'ratpoison support activated';
		}
	}

    #`ratpoison -c \"echo test $ratpoison_path\"`;

    #my $escaped = `echo \"TTYtter: $class - $text\" | iconv -c -f utf-8 -t ISO-8859-1`;
    #my $escaped = "$class - $text";

    #`$ratpoison_path -c \"echo $escaped\"`;

    `ratpoison -c \"echo $class: $text\"`;

    return 1;
}
1;
