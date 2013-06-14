#!/usr/bin/env perl

# use strict;
use warnings;

# Klassendefinition (abstrakte Klasse)
{ package Animal;
    use Carp qw( croak );
    # Konstruktoren
    sub named {
        ref( my $class = shift ) and croak "class name needed";
        my $name = shift;
        my $self = { Name => $name, Color => $class->default_color };
        bless $self, $class;
    }
    # virtuelle Methoden (Methoden, die in jedem Fall überschrieben werden sollen
    sub default_color { "brown" }
    sub sound { croak "subclass must define sound" }
    # Klassen-/Instanzmethoden
    sub speak {
        my $eingabe = shift;
        print $eingabe->name, " goes ", $eingabe->sound, "\n";
    }
    sub name {
        my $eingabe = shift;
        ref $eingabe
            ? $eingabe->{ Name }
            : "an unnamed $eingabe";
    }
    sub color {
        my $eingabe = shift;
        ref $eingabe
            ? $eingabe->{ Color }
            : default_color;
    }
    # reine Instanzmethoden
    sub set_name {
        ref( my $self = shift ) or croak "instance variable needed";
        $self->{ Name } = shift;
    }
    sub set_color {
        ref( my $self = shift ) or croak "instance variable needed";
        $self->{ Color } = shift;
    }
}

{ package Horse;
    our @ISA = qw( Animal );
    sub sound { "neigh" }
}
{ package Sheep;
    our @ISA = qw( Animal );
    sub sound { "baaah" }
    sub default_color { "white" }
}

my $tv_horse = Horse->named("Mr. Ed");
print $tv_horse->name, "\n";
$tv_horse->set_name("Mister Ed");
$tv_horse->set_color("grey");
print $tv_horse->name, " is ", $tv_horse->color, "\n";
print Sheep->name, " colored ", Sheep->color, " goes ", Sheep->sound, "\n";
