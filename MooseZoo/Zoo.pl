#!/usr/bin/env perl

use strict;
use warnings;

use Moose;
use Zoo::Animal;

my $allgemeinesTierchen = Animal->new( Name => 'Ally' );
print $allgemeinesTierchen->Name . "\n";