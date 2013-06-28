#!/usr/bin/env perl

package Country;
use Moose;
use Locale::Country;

print "Enter country code: ";
    chop(my $code = <STDIN>);
    my $country = code2country($code);
    if (defined $country)
    {
        print "$code = $country\n";
    }
    else
    {
        print "'$code' is not a valid country code!\n";
    }
