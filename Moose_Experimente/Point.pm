#!/usr/bin/env perl

# Konstruktor mit Moose
package Point;
    use Moose;
# Attribute der Klasse definieren
    has 'x' => (isa => 'Int', is => 'rw', required => 1);
    has 'y' => (isa => 'Int', is => 'rw', required => 1);

    sub clear {
        my $self = shift;
        $self->x(0);
        $self->y(0);
    }

# Klasse erweitern um ein Attribut
package Point3D;
    use Moose;
# 'extends' ist vergleichbar mit 'use base'
    extends 'Point';

    has 'z' => (isa => 'Int', is => 'rw', required => 1);

    after 'clear' => sub {
        my $self = shift;
        $self->z(0);
    };

package main;

    # Neue Objekte über den Konstruktor erstellen
    my $point1 = Point->new(x => 5, y => 7);
    my $point2 = Point->new({x => 5, y => 7});

    my $point3d = Point3D->new(x => 5, y => 42, z => -5);

    #Ausgabe der frisch erstellten Objekete im Koordinatensystem
    print( "Koordinaten von Punkt1: ",
            $point1->x,
            "|",
            $point1->y,
            "\n"
        );
    print( "Koordinaten von Punkt1: ",
            $point2->x,
            "|",
            $point2->y,
            "\n"
        );
    print( "Koordinaten von Punkt1: ",
            $point3d->x,
            "|",
            $point3d->y,
            "|",
            $point3d->z,
            "\n"
        );
