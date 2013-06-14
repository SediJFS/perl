#!/usr/bin/env perl

use strict;
use warnings;

#~ sub Cow::speak {
    #~ print "a Cow goes mooooo!\n";
#~ }
#~ sub Horse::speak {
    #~ print "a Horse goes neigh!\n";
#~ }
#~ sub Sheep::speak {
    #~ print "a Sheep goes baaaah!\n";
#~ }
#~ 
#~ my @pasture = qw(Cow Cow Horse Sheep Sheep Horse);
#~ foreach my $beast (@pasture) {
    #~ $beast->speak;          # Methodenaufruf
#~ }

# Hauptklasse Animal: bringt die Methode 'speak' mit
{ package Animal;
  sub speak {
      my $class = shift;
      print "a $class goes ", $class->sound, "!\n";
  }
}
# Unterklasse Cow: erzeugt nur noch das Geräusch für 'speak' selbst
# erbt die Methode 'speak' von Animal.
# @ISA = Vererbungsarray ('is a' -> 'ist ein') legt die übergeordnete Klasse fest,
# bzw die Elternklassen (es ist ein Array, also auch mehrere Werte möglich), die durchsucht
# werden sollen, wenn die Unterklasse eine Methode nicht enthält.
{ package Cow;
# @ISA mit 'our' als Packagevariable definieren
# für ältere Perl Versionen (vor 5.6) besser 'use vars qw(@ISA);'
    our @ISA = qw(Animal);
    sub sound { "mooooo" }
}
#Unterklasse Horse
# bessere weil kompaktere Version des Unterklassenaufrufs:
{ package Horse;
    use base qw(Animal);
    sub sound { "neigh" }
}
#Unterklasse Sheep
{ package Sheep;
    our @ISA = qw(Animal);
    sub sound { "baaaaah" }
}

# Methode 'speak' vom Objekt Cow aufrufen. Dadurch, dass über das Vererbungsarray
# @ISA die Klasse 'Animal' angegeben ist prüft Perl nach dem durchgehen der 
# Methoden der Unterklasse 'Cow' die Oberklasse 'Animal'. Äquivalent zu:
# Animal::speak("Cow");
Cow->speak;
Horse->speak;
Sheep->speak;

