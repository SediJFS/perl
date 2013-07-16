#!/usr/bin/env perl

use strict;

use Test::More tests => 2;
use lib '..';
use mailchecker;

use_ok( 'mailchecker' ) or exit;

my $server = 'imap.googlemail.com';
my $mail = mailchecker->new( $server, 'diskilla@gmail.com');
isa_ok( $mail, 'mailchecker');

#~ ok( exists $mail->{SERVER} does exist');
