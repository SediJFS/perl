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

my $muecke = Dog->new( name => 'Muecke', sound => 'Fiepfiep', attackPower => 15 );
print $muecke->speak() . "\n";

print "Lassie vs. Muecke\n", "...Fight!!!\n";
print $doggy->fight($muecke) . " wins\n";

#99 little bugs in the code
#99 little bugs in the code
#Take one down, patch it around
#117 little bugs in the code