#!/usr/bin/env perl

use strict;
use warnings;

{ package Animal;
    sub speak {
        my $class = shift;
        print " a $class goes ", $class->sound, "!\n";
    }
}

{ package Kuh;
    our @ISA = qw( Animal );
    sub sound { "muuuuh" }
}
{ package Pferd;
    our @ISA = qw( Animal );
    sub sound { "wieher" }
}
{ package Schaf;
    our @ISA = qw( Animal );
    sub sound { "määähhh" }
}
{ package Maus;
    our @ISA = qw( Animal );
    sub sound { "quiek" }
    sub speak {
        my $class = shift;
        $class->SUPER::speak;
        print "[aber du kannst sie fast nicht hören]\n";
    }
}

my @bauernhof = ();
{
    print "gib einen Tiernamen ein (nichts eingeben zum Beenden): ";
    chomp( my $animal = <STDIN> );
    $animal = ucfirst lc $animal;       # Eingabe auf erstem Buchstaben groß rest klein vereinheitlichen
    last unless $animal =~ /^(Kuh|Pferd|Schaf|Maus)$/;
    push( @bauernhof, $animal );
    redo;
}
foreach my $tier (@bauernhof) {
    $tier->speak;
}
