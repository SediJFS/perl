#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 13;
use lib '..';

use Zoo::Animal;
use Zoo::Dog;
use Zoo::Cat;

my $Tierchen = Animal->new( name => 'Ally' );
note( "Hat Tierchen einen Namen?" );
is( $Tierchen->{name}, 'Ally', 'Animal is named Ally' );
note( "kann Tierchen kämpfen?");
can_ok( $Tierchen, 'fight' );

my $doggy = Dog->new( name => 'Lassie' );
note( "ist unser Hund ein Hund?" );
isa_ok( $doggy, 'Dog' );
note( "hat unser Hund einen Namen und kann bellen?" );
is ( $doggy->{sound}, 'Woof', 'doggy can bark' );
is ( $doggy->{name}, 'Lassie', 'doggy is named Lassie' );
can_ok( $doggy, 'speak' );
note( "darf ich einen zweiten Hund anlegen?" );
my $doggyKlein = Dog->new( name => 'Muecke', sound => 'Fiepfiep' );
isa_ok( $doggyKlein, 'Dog' );
note( "wurde der initialsound geändert?" );
is ( $doggyKlein->{sound}, 'Fiepfiep', 'Muecke can say Fiepfiep' );

can_ok( $doggyKlein, 'fight' );
can_ok( $doggyKlein, 'bite' );
note( "now we create Fritzi the Cat" );
my $kitty = Cat->new( name => 'Fritzi' );
is( $kitty->{name}, 'Fritzi', 'kitty is named Fritzi' );
can_ok( $kitty, 'speak' );
can_ok( $kitty, 'claw' );
