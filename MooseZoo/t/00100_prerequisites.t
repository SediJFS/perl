#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 4;
use lib '..';

use Zoo::Animal;
use Zoo::Dog;

# werden die Module geladen
note( "Modulzugriff testen" );
use_ok( 'Zoo::Animal' ) or exit;
use_ok( 'Zoo::Dog' ) or exit;
use_ok( 'Zoo::Cat' ) or exit;
use_ok( 'Zoo::Monkey' ) or exit;
