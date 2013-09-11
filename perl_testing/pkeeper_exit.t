#!/usr/bin/env perl

use strict;
use warnings;

use lib 'lib';

use Test::More tests => 3;

my $exited;
BEGIN { *CORE::GLOBAL::exit = sub { $exited++ } };

my $module = 'PasswordKeeper';
use_ok( $module ) or die( "Could not load $module" );

my $mel = $module->new( 'Melanie' );
isa_ok( $mel, $module );

$mel->verify( $_ ) for qw( buffy babycat milkyway );
is( $exited, 1, 'verify() should exit if it receives three bad passwords' );
