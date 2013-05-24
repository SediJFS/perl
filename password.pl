#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Datum: 2013/05/24
# simple password-generator to generate a 8-digit random password

use strict;
use warnings;

use Log::Log4perl qw( :easy );

# Initialisieren von Log4perl
Log::Log4perl->easy_init( $ERROR );

# Zeichen festlegen, die im Passwort vorkommen dürfen
my @chars = ( "A".."Z", "a".."z", 0..9, qw( ! @ $ % & ) );
# mithilfe von join und der rand-function ein 8-stelliges Passwort aus dem
# vorgegebenen Zeichenpool generieren und ausgeben.
my $password = join("", @chars[ map { rand @chars } ( 1..8 ) ] );
print($password, "\n");
