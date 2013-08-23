#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Datum: 2013/05/24
# simple password-generator to generate a 8-digit random password

use strict;
use warnings;

use Log::Log4perl qw( :easy );

# Initialisieren von Log4perl
Log::Log4perl->easy_init( $DEBUG );

my $num_args = @ARGV;

my (
    $laenge,
) = @ARGV
;

# Zeichen festlegen, die im Passwort vorkommen dürfen
my @chars = ( "A".."Z", "a".."z", 0..9, qw( ! @ $ % & ) );

if (defined($laenge)) {
    # mithilfe von join und der rand-function ein n-stelliges Passwort aus dem
    # vorgegebenen Zeichenpool generieren und ausgeben.
    # wobei n = $laenge
    my $password = join("", @chars[ map { rand @chars } ( 1..$laenge ) ] );
    print($password, "\n");
} else {
    print "Keine Passwortlänge angegeben! ( 8 bis 10 )\n";
}
=pod

=head1 password

password gibt ein zufaelliges, n-stelliges Passwort aus dem Zeichenpool

"A".."Z"
"a".."z"
0..9
! @ $ % &

zurueck.

=head1 usage

password [laenge]

Beispiel:
password 15
gibt ein 15-stelliges Passwort zurück

=cut
