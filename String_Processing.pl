#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Datum: 2013/05/21
# Processing Strings and Arrays

use strict;
use warnings;

use Log::Log4perl qw( :easy );

# Initialisieren von Log4perl
Log::Log4perl->easy_init( $ERROR );

# String zum Weiterverarbeiten und Spielen einlesen
print("Bitte geben Sie einen Textstring ein: ");
my $TextString = <STDIN>;
chomp($TextString);

# String mithilfe von 'split' in Array umwandeln
my @ArrayAusString = split(//, $TextString);

# Kontrollausgabe
print("chars in string are: @ArrayAusString\n");

# Zum Spaß: Vorkommende Elemente von $TextString in absteigender Reihen-
# folge ausgeben
my %seen = ( );
foreach my $char (split //, $TextString) {
	$seen{$char}++;
}
print "unique chars are: ", sort(keys %seen), "\n";

# einfaches Reverse mit der bereits existierenden Funktion reverse();
my $reversedString = reverse($TextString);
my $reversedArray = reverse(@ArrayAusString);
print "reversed chars in string: ", $reversedString, "\n";
print "reversed chars in array: ", $reversedArray, "\n";
