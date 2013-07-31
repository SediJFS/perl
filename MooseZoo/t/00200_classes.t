#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 10;
use lib '..';

use Zoo::Animal;
use Zoo::Dog;
use Zoo::Cat;
use Zoo::Monkey;

# Objekte anlegen (Animal soll später nicht verwendet werden sondern nur als Oberklasse dienen)
note( "Objekte anlegen" );
my $tierchen = Animal->new( name => 'Ally' );
my $doggy = Dog->new( name => 'Lassie' );
my $kitty = Cat->new( name => 'Fritzi' );
my $monkey = Monkey->new( name => 'Louis' );
# Objekte testen
isa_ok( $tierchen, 'Animal' );
isa_ok( $doggy, 'Dog' );
isa_ok( $kitty, 'Cat' );
isa_ok( $monkey, 'Monkey' );
# Objektattribute testen
note( "Objektattribute testen" );
note( "name" );
is( $doggy->{name}, 'Lassie', '$doggy is named' );
is( $kitty->{name}, 'Fritzi', '$kitty is named' );
is( $monkey->{name}, 'Louis', '$monkey is named' );
note( "attackPower" );
is( $doggy->{attackPower}, 10, '$doggy has attackPower' );
is( $kitty->{attackPower}, 12, '$kitty has attackPower' );
is( $monkey->{attackPower}, 15, '$monkey has attackPower' );