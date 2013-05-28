#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Datum: 2013/05/28
# CSV-Datei aus Array erstellen

use strict;
use warnings;

use Log::Log4perl qw( :easy );
use File::Find;

# Initialisieren von Log4perl
Log::Log4perl->easy_init( $DEBUG );

my $dir = "/home/josef/Bilder";
my @dateien;
push(@dateien, find(\&wanted, $dir) );
find(\&wanted, $dir);
#DEBUG @dateien;
#&open_file_to_write(@dateien);

sub wanted {
    
    print if -f;
}

# Subroutine um eine csv-Liste zu erstellen
sub csv {
    my @csvEintraege = join (",", @_);
    return @csvEintraege;
}

sub open_file_to_write {
    my $csv = "output.csv";
    open (DATEI, "$csv") or die $!;
    print DATEI ( @_ );
    close (DATEI);
}
