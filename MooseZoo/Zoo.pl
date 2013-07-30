#!/usr/bin/env perl

use strict;
use warnings;

# Bequemes Loggen:
use Log::Log4perl qw( :easy );
Log::Log4perl->easy_init( $DEBUG );

use lib './Zoo';
use Moose;

use Dog;

my $doggy = Dog->new( name => 'Lassie', sound => 'Barkbark' );
print $doggy->name . "\n";
print $doggy->speak() . "\n";

my $muecke = Dog->new( name => 'Muecke', sound => 'Fiepfiep', attackPower => 5 );
print $muecke->speak() . "\n";

until ( $muecke->{energy} == 0 or $doggy->{energy} == 0 ) {
    print "--------------------\n";
    my $ownApAfterRound = $muecke->{energy};
    my $enemyApAfterRound = $doggy->{energy};
    print "AP " . $doggy->{name} . ': ' . $ownApAfterRound . "\n";
    print "AP " . $muecke->{name} . ': ' . $enemyApAfterRound . "\n";
    $muecke->fight($doggy);
}
if ( $muecke->{energy} == 0 ) {
    print "--------------------\n" . $doggy->{name} . " won the fight\n";
} else {
    print "--------------------\n" . $muecke->{name} . " won the fight\n";
}