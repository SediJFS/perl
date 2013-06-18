#!/usr/bin/env perl
# Lösungen zu Übung 2 Kapitel 4
#~ use strict;
#~ use warnings;

my $all = "**all machines**";

my %total_bytes;
while ( <> ) {
    next if /^#/;
    my ( $source, $destination, $bytes ) = split;
    $total_bytes{$source}{$destination} += $bytes;
    $total_bytes{$source}{$all} += $bytes;
}

my @sources =
    sort { $total_bytes{$b}{$all} <=> $total_bytes{$a}{$all} }
    keys %total_bytes;

for my $source (@sources) {
    my $tb = $total_bytes{$source};
    my @destinations =
        sort { $tb{$b} <=> $tb{$a} } keys %$tb;
    print "$source: $tb{$all} total bytes sent\n";
    for my $destination (@destinations) {
        next if $destination eq $all;
        print " $source => $destination:",
            " $tb{$destiantion} bytes\n";
    }
    print "\n";
}
