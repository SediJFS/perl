#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Datum: 2013/04/06
# Simple File Lister

use strict;
use warnings;

use Log::Log4perl qw( :easy );
Log::Log4perl->easy_init( $DEBUG );

# Pfad eingabe abfragen
print( "Bitte geben Sie einen absoluten Pfad an: " );
my $pfad = <STDIN>;
chomp( $pfad );
# eingegebenen Pfad öffnen mit opendir
opendir( DIR, $pfad ) || die;
# Variablen deklarieren
my $verzeichnis = "";
my @verzeichnisse = ();
# Inhalt des geöffneten Dateipfads auslesen und in Array schreiben
foreach $verzeichnis( readdir DIR ) {
	push( @verzeichnisse, $verzeichnis );
}
# Array sortieren
@verzeichnisse = sort( @verzeichnisse );
# Auswahlmenü ausgeben
print(
	"\nBitte wählen: ", "\n",
	"1: alle Dateien anzeigen", "\n",
	"2: versteckte Dateien ausblenden", "\n\n"
	);
my $auswahl = <STDIN>;
chomp( $auswahl );
# entsprechen Auswahl alle Dateien oder nur die ohne "." ausgeben
# Auswahl 1: nur Einträge die nicht mit "." beginnen ausgeben
print( 
	"\nAusgelesene Dateien (alphabetisch sortiert): ", 
	"\n---------------------------------------------\n"
	);
if ( $auswahl == '2') {
	foreach my $eintrag ( @verzeichnisse ) {
		my $einzelpfad = $eintrag;	
	
		if ( $einzelpfad !~ m/^\..*/ ) {
			print( $einzelpfad, "\n" );
		}
		else {
			next;
		}
	}
}
# Auswahl 2: Alle Einträge ausgeben
else {
	foreach my $eintrag ( @verzeichnisse ) {
		print( $eintrag, "\n" );
	}		
}
# Verzeichnis wieder schließen
closedir( DIR );

