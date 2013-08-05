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

my $ownApAfterRound = $muecke->{energy};
my $enemyApAfterRound = $doggy->{energy};
until ( $muecke->{energy} <= 0 || $doggy->{energy} <= 0 ) {
    print "--------------------\n";
    $muecke->fight($doggy);
    $doggy->fight($muecke);
    print "AP " . $doggy->{name} . ': ' . $ownApAfterRound . "\n";
    print "AP " . $muecke->{name} . ': ' . $enemyApAfterRound . "\n";
}
if ( $ownApAfterRound <= 0 ) {
    print "--------------------\n" . $doggy->{name} . " won the fight\n";
    print "Final energy " . $doggy->{name} . ": " . $doggy->{energy} . "\n";
    print "Final energy " . $muecke->{name} . ": " . $muecke->{energy} . "\n";
} else {
    print "--------------------\n" . $muecke->{name} . " won the fight\n";
    print "Final energy " . $muecke->{name} . ": " . $muecke->{energy} . "\n";
    print "Final energy " . $doggy->{name} . ": " . $doggy->{energy} . "\n";
}
