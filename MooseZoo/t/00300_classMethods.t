#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 25;
use lib '..';

use Zoo::Animal;
use Zoo::Dog;
use Zoo::Cat;
use Zoo::Monkey;

my $doggy = Dog->new( name => 'Lassie' );
my $kitty = Cat->new( name => 'Fritzi' );
my $monkey = Monkey->new( name => 'Louis' );

# Objekte testen
note( "Objekte testen" );
isa_ok( $doggy, 'Dog' );
isa_ok( $kitty, 'Cat' );
isa_ok( $monkey, 'Monkey' );

# Klassenmethoden testen
note( "Klassenmethoden testen" );

# speak()
can_ok( $doggy, 'speak' );
can_ok( $kitty, 'speak' );
can_ok( $monkey, 'speak' );

# fight()
can_ok( $doggy, 'fight' );
can_ok( $kitty, 'fight' );
can_ok( $monkey, 'fight' );

# check_energy()
can_ok( $doggy, 'check_energy' );
can_ok( $kitty, 'check_energy' );
can_ok( $monkey, 'check_energy' );

# check_state()
can_ok( $doggy, 'check_state' );
can_ok( $kitty, 'check_state' );
can_ok( $monkey, 'check_state' );

# finish_him()
can_ok( $doggy, 'finish_him' );
can_ok( $kitty, 'finish_him' );
can_ok( $monkey, 'finish_him' );

# Objektmethoden testen
note( "Objektmethoden testen" );

# Objekt vom Typ 'Dog'
note( "Objekt vom Typ 'Dog'" );
can_ok( $doggy, 'bite' );
can_ok( $doggy, 'play_ball' );

# Objekt vom Typ 'Cat'
note( "Objekt vom Typ 'Cat'" );
can_ok( $kitty, 'claw' );
can_ok( $kitty, 'play_kill' );
can_ok( $kitty, 'purr' );

#Objekt vom Typ 'Monkey'
note( "Objekt vom Typ 'Monkey");
can_ok( $monkey, 'strangle' );
can_ok( $monkey, 'strangle_with_both_hands' );
