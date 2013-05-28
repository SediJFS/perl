#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Datum: 2013/05/28
# CSV-Datei aus Array erstellen

use strict;
use warnings;

use Log::Log4perl qw( :easy );

# Initialisieren von Log4perl
Log::Log4perl->easy_init( $ERROR );

# Variablen deklarieren
my @csvEintraege = ();
my $verzeichnis = "";
my @verzeichnisse = ();
# Pfad zu den Bildern definieren
my $pfad = "/home/extcjs/Bilder";

&dateienAuslesen($pfad);
&csvSchreiben(&csv(@verzeichnisse) );

# Subroutine um eine csv-Liste zu erstellen
sub csv {
    my @csvEintraege = join (",", @_);
    return @csvEintraege;
}
# Subroutine um Dateien aus Pfad auszulesen
sub dateienAuslesen {
    opendir( DIR, $pfad ) || die $!;

    foreach $verzeichnis( readdir DIR ) {
        push( @verzeichnisse, $verzeichnis );
    }
    return @verzeichnisse;
}
# Subroutine um den Inhalt des erstellten Arrays in eine CSV zu schreiben.
sub csvSchreiben {
    open (WRITE, ">testwrite.csv") or die $!;
    print WRITE @_;
    close (WRITE);
}
