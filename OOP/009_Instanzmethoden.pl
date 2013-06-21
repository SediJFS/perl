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

{ package Animal;
    our @ISA = qw( LivingCreature );
    sub sound { die "all Animals should define a sound" }
    sub default_color { "brown" }
    sub speak {
        my $either = shift;
        print $either->name, " goes ", $either->sound, "\n";
    }
    sub name {
        my $either = shift;
        ref $either
          ? $either->{ Name }
          : "an unnamed $either";
    }
    sub named {
        my $class = shift;
        my $name = shift;
        my $self = { Name => $name, Color => $class->default_color };
        bless $self, $class;
    }
    sub eat {
        my $either = shift;
        my $food = shift;
        print $either->name, " eats $food.\n";
    }
    sub color {
        my $self = shift;
        if (@_) {   # falls ein argument angegeben wurde: setter
            $self->{ Color } = shift;
        } else {    # falls kein argument angegeben wurde: getter
            $self->{ Color };
        }
    }
    #~ sub set_color {
        #~ my $self = shift;
        #~ if ( defined wantarray ) {
            #~ my $old = $self->{ Color };
            #~ $self->{ Color } = shift;
            #~ $old;
        #~ } else {
            #~ $self->{ Color } = shift;
        #~ }
    #~ }
}

{ package Horse;
    our @ISA = qw( Animal );
    sub sound { "neigh" }
}
{ package Sheep;
    our @ISA = qw( Animal );
    sub sound { "baaaah" }
    sub default_color { "white" }
}

my $tv_horse = Horse->named( "Mr. Ed" );
$tv_horse->color("grey");
print $tv_horse->name, " is colored ", $tv_horse->color, "\n";
