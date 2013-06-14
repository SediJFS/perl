#!/usr/bin/env perl

use strict;
use warnings;

{ package LivingCreature;
    sub speak {
        my $class = shift;
        if ( @_ ) {
            print "a $class goes '@_'\n";
        } else {
            print "a $class goes ", $class->sound, "\n";
        }
    }
}
{ package Person;
    our @ISA = qw( LivingCreature );
    sub sound { "mhmmmm" }
}

{ package Animal;
    our @ISA = qw( LivingCreature );
    sub sound { die "all Animals should define a sound" }
    sub speak {
        my $class = shift;
        die "animals can't talk!" if @_;
        $class->SUPER::speak;
    }
}
{ package Cow;
    our @ISA = qw( Animal );
    sub sound { "mooooh" }
}
{ package Horse;
    our @ISA = qw( Animal );
    sub sound { "neigh" }
}
{ package Sheep;
    our @ISA = qw( Animal );
    sub sound { "baaaah" }
}
{ package Mouse;
    our @ISA = qw( Animal );
    sub sound { "squeak" }
    sub speak {
        my $class = shift;
        $class->SUPER::speak;
        print "[but you can barely hear it]\n";
    }
}

my @bauernhof = ();
{
    print "please enter an animalname (empty to finish): ";
    chomp( my $animal = <STDIN> );
    $animal = ucfirst lc $animal;       # Eingabe auf erstem Buchstaben groß rest klein vereinheitlichen
    last unless $animal =~ /^(Cow|Horse|Sheep|Mouse)$/;
    push( @bauernhof, $animal );
    redo;
}
foreach my $tier (@bauernhof) {
    $tier->speak;
}
Person->speak;
Person->speak("Ruhe da draußen!");
