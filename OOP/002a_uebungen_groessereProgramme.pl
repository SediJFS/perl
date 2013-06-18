#!/usr/bin/env perl
# Kapitel 2 Übungen:
# Diese Datei ist zu Übungszwecken im Unterordner Oogaboogoo als date.pl abgelegt
package Oogaboogoo::date;

use strict;
use warnings;

my @day = qw( ark dip wap sen pop sep kir );
my @mon = qw( dit pod bod rod sip wax lin sen kun fiz nap dep );
# Subroutine zum Umsetzen einer Zahl in einen Wochentag:
sub day {
    my $num = shift @_;
    die "$num ist keine Wochentagsnummer";
        unless $num >= 0 and $num <= 6;
    $day[$num];
}
# SUbroutine zum Umsetzen einer Zahl in einen Monat:
sub mon {
    my $num = shift @_;
    die "$num ist keine Monatsnummer";
        unless $num >= 0 and $num <= 11;
    $mon[$num];
}
#Make perl happy:
1;

