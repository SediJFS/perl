#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Datum: 2013/05/28
# Bilder aus Pfad auslesen (using File::Find)
# anschließend in CSV-Datei schreiben.

use strict;
use warnings;

use Log::Log4perl qw( :easy );
use File::Find;

# Initialisieren von Log4perl.
Log::Log4perl->easy_init( $ERROR );
# Variablen Deklarationen und Definitionen:
my $dir;
my $num_args = $#ARGV + 1;
my $was = $ARGV[0];
my $nr = $ARGV[1];
my $unterverz = $ARGV[2];
my $prefix = "/home/extcjs/";   # später für EWV '/i/fotos/'
# prüfen ob, und wieviele Argumente angegeben wurden und entsprechend den daraus
# erstellten Pfad anpassen.
if ($num_args == 1) {
    $dir = $prefix . $was . "/";
    &main($dir);
} elsif ($num_args == 2) {
    $dir = $prefix . $was . "/" . $nr . "/";
    &main($dir);
} elsif ($num_args == 3) {
    $dir = $prefix . $was . "/" . $nr . "/" . $unterverz . "/";
    &main($dir);
} else {
    print "Zu wenig oder zu viele Argumente!\n";
    exit;
}

DEBUG $dir;

sub main {
    my @dateien;
    # mit File::Find und einer anonymen Funktion als Parameter den Ordner durchsuchen
    # und das Ergebnis in das Array @dateien schreiben, wenn es nicht mit '.' oder
    # '..' beginnt.
    # Der Reguläre Ausdruck '/^.*(?:jpg|gif|png)$/' prüft, ob die Dateiendung jpg,
    # gif oder png ist damit nur diese Dateien zurückgegeben werden.
    find(sub { if ( ($_ !~ m/^\..*/) and ( $_ =~ /^.*(?:jpg|gif|png)$/ ) and (-f $_) ){
                    push @dateien , $_;
                    }
             }, $dir
        );
    # Den Inhalt von @dateien aufsteigend sortieren und mit der Funktion 'csv' weiter
    # bearbeiten.
    my @gesuchteDateien = &csv(sort(@dateien));
    # Das (nun mit Kommas getrennte) Array anschließend in die Datei 'output.csv'
    # schreiben.
    &open_file_to_write(@gesuchteDateien);
}

# Subroutine um eine csv-Liste zu erstellen.
# Der Line Feed nach dem Komme entspricht der Definition einer CSV-Datei:
# Jeder Eintrag in einer Zeile (bzw. jeder Eintrag endet mit Line Feed oder
# Carrige Return
sub csv {
    my @csvEintraege = join (",\n", @_);
    return @csvEintraege;
}

# Subroutine um die Datei 'output.csv' zu öffnen und das übergebene Array rein
# zu schreiben.
sub open_file_to_write {
    my $csv = "output.csv";
    open (DATEI, ">$csv") or die $!;
    print DATEI ( @_ );
    close (DATEI);
    print "Datei './output.csv' erstellt!\n";
}
