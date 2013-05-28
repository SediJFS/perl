#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Datum: 2013/05/28
# CSV-Datei aus Array erstellen

use strict;
use warnings;

use Log::Log4perl qw( :easy );

# Initialisieren von Log4perl
Log::Log4perl->easy_init( $DEBUG );

# Variablen deklarieren
my $daten;
my $verzeichnis = "";
my @verzeichnisse = ();
my @csvEintraege = ();
# Pfad zu den Bildern definieren
my $pfad = "<Dateipfad>";
my $datei = "<Dateiname>";

&makeCSV($datei);

#Subroutine zum Erstellen der CSV-Datei
sub makeCSV {
    # Prüfen ob die Datei schon vorhanden ist:
    # mit dem Operator '-e' (exists) wird geprüft, ob eine Datei existiert.
    # DEBUG $datei;
    if (-e @_) {
        open (DATEI, @_) or die $!;
    # Wenn Datei vorhanden, Daten aus Verzeichnis auslesen und in Array schreiben
        opendir( DIR, $pfad ) || die $!;
        foreach $verzeichnis( readdir DIR ) {
    # Prüfen, ob die aktuell für das Array gelesene Datei mit . oder .. beginnt
            if ( $verzeichnis !~ m/^\..*/ ) {
                push( @verzeichnisse, $verzeichnis );
            }
            else {
                next;
            }
        }
        print DATEI ( &csv(@verzeichnisse) );
    # Datei wieder schließen
        close (DATEI);
    # Array zurückgeben
        return @verzeichnisse;
        # DEBUG @verzeichnisse;
    }
    else {
        open (DATEI, ">test.csv") or die $!;
        opendir( DIR, $pfad ) || die $!;
        foreach $verzeichnis( readdir DIR ) {
            if ( $verzeichnis !~ m/^\..*/ ) {
                push( @verzeichnisse, $verzeichnis );
            }
            else {
                next;
            }
        }
        print DATEI ( &csv(@verzeichnisse) );
        close (DATEI);
        # DEBUG @verzeichnisse;
    }
}

# Subroutine um eine csv-Liste zu erstellen
sub csv {
    @csvEintraege = join (",", @_);
    return @csvEintraege;
}
