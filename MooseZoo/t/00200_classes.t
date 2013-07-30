#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 19;
use lib '..';

use Zoo::Animal;
use Zoo::Dog;
use Zoo::Cat;

# Allgemeines Animal 'Tierchen' anlegen (Animal ist später nicht von Hand aufzurufen)
my $Tierchen = Animal->new( name => 'Ally' );

# Hat das Tierchen auch einen Namen?
note( "Hat Tierchen einen Namen?" );
is( $Tierchen->{name}, 'Ally', 'Animal is named Ally' );

# kann das Tierchen kämpfen?
note( "kann Tierchen kämpfen?");
can_ok( $Tierchen, 'fight' );
my $doggy = Dog->new( name => 'Lassie' );

# ist unser Hund ein Objekt vom Typ 'Hund'?
note( "ist unser Hund ein Hund?" );
isa_ok( $doggy, 'Dog' );

# hat unser Hund einen Namen und kann bellen?
note( "hat unser Hund einen Namen und kann bellen?" );
is ( $doggy->{sound}, 'Woof', 'doggy can bark' );
is ( $doggy->{name}, 'Lassie', 'doggy is named Lassie' );
can_ok( $doggy, 'speak' );

# darf ich einen zweiten Hund anlegen?
note( "darf ich einen zweiten Hund anlegen?" );
my $doggyKlein = Dog->new( name => 'Muecke', sound => 'Fiepfiep' );
isa_ok( $doggyKlein, 'Dog' );

# wurde der intialsound geändert?
note( "wurde der initialsound geändert?" );
is ( $doggyKlein->{sound}, 'Fiepfiep', 'Muecke can say Fiepfiep' );
can_ok( $doggyKlein, 'fight' );
can_ok( $doggyKlein, 'bite' );
note( "now we create Fritzi the Cat" );
my $kitty = Cat->new( name => 'Fritzi' );
is( $kitty->{name}, 'Fritzi', 'kitty is named Fritzi' );

# Klassenmethoden testen
note( "Klassenmethoden testen" );
can_ok( $kitty, 'speak' );
can_ok( $kitty, 'claw' );
can_ok( $doggy, 'check_energy' );
can_ok( $doggyKlein, 'check_energy' );
can_ok( $kitty, 'check_energy' );
can_ok( $doggy, 'check_state' );
can_ok( $doggyKlein, 'check_state' );
can_ok( $kitty, 'check_state' );