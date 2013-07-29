#!/usr/bin/env perl

use strict;
use warnings;

use lib './Zoo';
use Moose;
use Zoo::Animal;
use Dog;

my $allgemeinesTierchen = Animal->new( name => 'Ally' );
print $allgemeinesTierchen->name . "\n";
my $doggy = Dog->new( name => 'Lassie', sound => 'Barkbark' );
print $doggy->name . "\n";
print $doggy->speak() . "\n";