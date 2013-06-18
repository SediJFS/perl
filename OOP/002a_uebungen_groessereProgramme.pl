#!/usr/bin/env perl
# Kapitel 2 Übungen:
# Diese Datei ist zu Übungszwecken im Unterordner Oogaboogoo als date.pl abgelegt

use strict;
require 'Oogaboogoo/date.pl';

my( $sec, $min, $hour, $mday, $mon, $year, $wday ) = localtime;

my $day_name = Oogaboogoo::date::day( $wday );
my $mon_name = Oogaboogoo::date::mon( $mon );
$year += 1900;

print "Heute ist $day_name, $mon_name $mday, $year.\n"
