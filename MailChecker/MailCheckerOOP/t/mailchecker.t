#!/usr/bin/env perl

use strict;

use Test::More tests => 1;
use lib '..';
use mailchecker;

my $mail = mailchecker->new();
isa_ok( $mail, 'mailchecker');
