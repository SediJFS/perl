#!/usr/bin/env perl

package Country;
use Moose;
use Locale::Country;

has 'country' => ( isa => 'Str', is => 'rw');
has 'code' => ( isa => 'Str', is => 'rw' );

#~ sub get_country_code {
    #~ my $self = shift;
    #~ my $country = code2country($self);
    #~ if (defined $country)
    #~ {
        #~ return "$self = $country\n";
    #~ }
    #~ else
    #~ {
        #~ return "'$self' is not a valid country code!\n";
    #~ }
#~ }
#~ my $searchedCountry = Country->new();
#~ print "Enter country code: ";
    #~ chop(my $code = <STDIN>);
#~ $searchedCountry->code($code);
#~ my @ausgabe = $searchedCountry->get_country_code;
#~ print @ausgabe;

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
