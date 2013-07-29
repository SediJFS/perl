#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 6;
use lib '..';

use Zoo::Animal;
use Zoo::Dog;

use_ok( 'Zoo::Animal' ) or exit;
use_ok( 'Zoo::Dog' ) or exit;
use_ok( 'Zoo::Cat' ) or exit;

my $Tierchen = Animal->new( name => 'Ally' );
my $doggy = Dog->new( name => 'Lassie' );
my $kitty = Cat->new( name => 'Fritzi' );

isa_ok( $Tierchen, 'Animal' );
isa_ok( $doggy, 'Dog' );
isa_ok( $kitty, 'Cat' );
