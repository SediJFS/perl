#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 12;
use lib '..';

use Zoo::Animal;
use Zoo::Dog;
use Zoo::Cat;

my $Tierchen = Animal->new( name => 'Ally' );
# Hat $Tierchen einen Namen?
is( $Tierchen->{name}, 'Ally', 'Animal is named Ally' );
# kann $Tierchen kämpfen?
can_ok( $Tierchen, 'fight' );

my $doggy = Dog->new( name => 'Lassie' );
# ist unser Hund ein Hund?
isa_ok( $doggy, 'Dog' );
# hat unser Hund einen Namen und kann bellen?
is ( $doggy->{sound}, 'Woof', 'doggy can bark' );
is ( $doggy->{name}, 'Lassie', 'doggy is named Lassie' );
can_ok( $doggy, 'speak' );
# darf ich einen zweiten Hund anlegen, der seinen 'sound' initial ändert?
my $doggyKlein = Dog->new( name => 'Muecke', sound => 'Fiepfiep' );
# wurde der initialsound geändert?
is ( $doggyKlein->{sound}, 'Fiepfiep', 'Muecke can say Fiepfiep' );

can_ok( $doggyKlein, 'fight' );
can_ok( $doggyKlein, 'bite' );

my $kitty = Cat->new( name => 'Fritzi' );
is( $kitty->{name}, 'Fritzi', 'kitty is named Fritzi' );
can_ok( $kitty, 'speak' );
can_ok( $kitty, 'claw' );