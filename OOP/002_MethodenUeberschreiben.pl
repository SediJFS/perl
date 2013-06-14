#!/usr/bin/env perl

use strict;
use warnings;

# Hauptklasse Animal: bringt die Methode 'speak' mit
{ package Animal;
    sub speak {
        my $class = shift;
        print "a $class goes ", $class->sound, "!\n";
    }
}
# Objekt Mouse erstellen vom Typ Animal
# Diesmal bringt Mouse eine eigene Methode 'speak' mit, welche die von Animal
# mitgebrachte Methode auf Grund der Vererbungshierarchie überschreibt. 
#~ { package Mouse;
    #~ our @ISA = qw( Animal );
    #~ sub sound { "squeak" }
    #~ sub speak {
        #~ my $class = shift;
        #~ print "a $class goes ", $class->sound, "!\n";
        #~ print "[but you can barely hear it!]\n";
    #~ }
#~ }
# Bei der oberen Variante wurde die Methode 'speak' zwar überschrieben, aber wir 
# haben wieder redundanten Code. Wenn jetzt am Text von 'speak' z.b. das 'goes' 
# zu 'says' geändert werden soll, muss an mehreren Stellen im Code eine Änderung
# vorgenommen werden.
#~ { package Mouse;
    #~ our @ISA = qw( Animal );
    #~ sub sound { "squeak" }
    #~ sub speak {
        #~ my $class = shift;
        #~ Animal::speak($class);
        #~ # Nicht gut, das der Klassenname 'Animal' fest in die Subroutine einprorammiert ist.
        #~ # Wenn jetzt 'Animal' die Methode speak von einer weitern Oberklasse erben
        #~ # würde bekämen wir einen Fehler.
        #~ # Eine bessere Lösung besteht darin, Perl anzuweisen, an einer anderen Stelle in der
        #~ # Vererbungskette mit der Suche zu beginnen (Siehe Beispiel unten)
        #~ print "[but you can barely hear it!]\n";
    #~ }
#~ }
{ package Horse;
    our @ISA = qw( Animal );
    sub sound { "neigh" }
}
{ package Pig;
    our @ISA = qw( Animal );
    sub sound { "oinkoink" }
}
{ package Sheep;
    our @ISA = qw( Animal );
    sub sound { "baaaaaah" }
}
{ package Cow;
    our @ISA = qw( Animal );
    sub sound { "mooooooh" }
}
{ package Mouse;
    our @ISA = qw( Animal );
    sub sound { "squeak" }
    sub speak {
        my $class = shift;
        $class->SUPER::speak;
        print "[but you can barely hear it!]\n";
    }
}
Horse->speak;
Pig->speak;
Sheep->speak;
Cow->speak;
Mouse->speak;
