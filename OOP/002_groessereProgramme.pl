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

# Auslagern von SUbroutinen in andere .pl-Dateien:
# die Subroutinen können z.B. mit 'do' eingebunden werden
do "drop_anchor.pl";
die $@ if $@;
do "navigate.pl";
die $@ if $@;

# Wenn 'navigate.pl' jetzt aber selbst auch ein 'do "drop_anchor.pl"' enthält,
# würde die Datei zweimal geladen. Um das zu verhindern:
require "drop_anchor.pl";
require "navigate.pl";
# Bei syntaxfehlern in der Datei löst 'require' automatisch ein 'die' aus,
# weshalb die beiden Zeilen 'die $@ if $@' überflüssig werden.

# Zum Auslesen der aktuellen Perl-Pfadvariablen:
# Unix-Kommandozeile:
# perl -le 'print for @INC'

# um die Pfadvariable zu erweitern (Am Anfang der Liste mit unshift hinzufügen):
unshift @INC, "/Pfad/zur/perl-lib";

# Um Namensprobleme zu vermeiden besser mit Packages arbeiten. Diese werden in
# der jeweiligen pl definiert. Also steht in 'Navigation.pl':
package Navigation;
# Dadurch werden die Subroutinen aus Navigation nur noch mit vorangestelltem
# Packagenamen aufgerufen werden können:
Navigation::turn_towards_heading();
