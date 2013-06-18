#!/usr/bin/env perl

use strict;
use warnings;
# Kapitel 2:

# Beispielcode des Skipper
sub turn_towards_heading {
# auf neuen Kurs gehen
    my $new_heading = shift;
    my $current_heading = current_heading( );
    print "Current heading is ", $current_heading, ".\n";
    print "Come about to $new_heading ";
    my $direction = "right";
    my $turn = ($new_heading - $current_heading) % 360;
    if ($turn > 180) { # große Wende
        $turn = 360 - $turn;
        $direction = "left";
    }
    print "by turning $direction $turn degrees.\n";
}

# modifizierter Code des Skipper mit Prüfen ob Kursänderung mit Nullwert
sub turn_towards_heading {
    my $new_heading = shift;
    my $current_heading = current_heading( );
    print "Current heading is ", $current_heading, ".\n";
    my $direction = "right";
    my $turn = ($new_heading - $current_heading) % 360;
    unless ($turn) {
        print "On course (good job!).\n";
        return;
    }
    print "Come about to $new_heading ";
    if ($turn > 180) { # große Wende
        $turn = 360 - $turn;
        $direction = "left";
    }
    print "by turning $direction $turn degrees.\n";
}
