#!/usr/bin/env perl

package Country;
use Moose;
use Locale::Country;
use Log::Log4perl qw( :easy );

# Initialisieren von Log4perl
Log::Log4perl->easy_init( $DEBUG );

has 'country' => ( isa => 'Str', is => 'rw');
has 'code' => ( isa => 'Str', is => 'rw' );

sub get_country_name {
    my $self = shift;
    my $country = code2country($self->code);
    DEBUG $country;
    if (defined $country)
    {
        return $self->code . " = " . $country . "\n";
    }
    else
    {
        return $self->country ." is not a valid country code!\n";
    }
}

sub get_country_code {
    my $self = shift;
    my $code = country2code($self->country);
    if (defined $code)
    {
        return $self->country . " = " . $code . "\n";
    }
    else
    {
        return $self->code . " is not a valid country name!\n";
    }
}

my $searchedCountry = Country->new();
print "Enter country code or name: ";
    chop(my $eingabe = <STDIN>);

my $ergebnis;

if ( $eingabe =~ /^[A-Za-z]{0,2}$/ ) {
    $searchedCountry->code($eingabe);
    $ergebnis = $searchedCountry->get_country_name;
} else {
    $searchedCountry->country($eingabe);
    $ergebnis = $searchedCountry->get_country_code;
}
print $ergebnis;
