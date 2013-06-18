#!/usr/bin/env perl

use strict;
use warnings;

use IO::File;
my %output_handles;
while (<>) {
    # Mit while-Schleife den Namen der Person aus der Datenzeile extrahieren.
    # Mit RegEx nur die Zeichen extrahieren, die am Anfang des Strings vor einem
    # oder mehreren Leerzeichen gefolgt von einem ':' stehen. 
    unless ( /^(\S+):/ ) {
        warn "ignoring the line with missing name: $_";
        next;
    }
    # Den gefundenen Namen vereinheitlichen
    my $name = lc $1;
    # Dateihandle kreiren und nutzen. Im Falle eines nicht vorhandenen Handles
    # wird ein neues angelegt.
    my $handle = $output_handles{ $name }
        ||= IO::File->new( ">$name.info" )
        || die "Cannot create $name.info";
    print $handle $_;
}
