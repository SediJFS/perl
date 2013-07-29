#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 4;
use lib '..';

use Zoo::Animal;
# Dürfen wir 'Zoo::Animal' benutzen?
use_ok( 'Zoo::Animal' ) or exit;
my $Tierchen = Animal->new( Name => 'Ally' );
isa_ok( $Tierchen, 'Animal' );
# Hat $Tierchen einen Namen?
is( $Tierchen->{Name}, 'Ally', 'Animal is named Ally' );
# kann $Tierchen kämpfen?
can_ok( $Tierchen, 'Fight' );