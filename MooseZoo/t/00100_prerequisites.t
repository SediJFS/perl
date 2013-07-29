#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 9;
use lib '..';

use Zoo::Animal;
use Zoo::Dog;

# Dürfen wir 'Zoo::Animal' benutzen?
use_ok( 'Zoo::Animal' ) or exit;
my $Tierchen = Animal->new( name => 'Ally' );
isa_ok( $Tierchen, 'Animal' );
# Hat $Tierchen einen Namen?
is( $Tierchen->{name}, 'Ally', 'Animal is named Ally' );

# kann $Tierchen kämpfen?
can_ok( $Tierchen, 'fight' );

# darf ich Hunde anlegen?
use_ok( 'Zoo::Dog' ) or exit;
my $doggy = Dog->new( name => 'Lassie' );
isa_ok( $doggy, 'Dog' );
is ( $doggy->{sound}, 'Woof', 'doggy can bark' );
is ( $doggy->{name}, 'Lassie', 'doggy is named Lassie' );
can_ok( $doggy, 'speak' );