#!/usr/bin/env perl

package Eq;
use Moose::Role;

requires 'equal_to';

sub not_equal_to {
    my ( $self, $other ) = @_;
    not $self->equal_to($other);
}

package Comparable;
use Moose::Role;
# Das Package 'Comparable' übernimmt mit 'with' die Rolle von 'Eq'. Dadurch
# steht 'Comparable' auch die Subroutine 'not_equal_to' zur Verfügung.
with 'Eq';

requires 'compare';

sub equal_to {
    my ( $self, $other ) = @_;
    $self->compare($other) == 0;
}

sub greater_than {
    my ( $self, $other ) = @_;
    $self->compare($other) == 1;
}

sub less_than {
    my ( $self, $other ) = @_;
    $self->compare($other) == -1;
}

sub greater_than_or_equal_to {
    my ( $self, $other ) = @_;
    $self->greater_than($other) || $self->equal_to($other);
}

sub less_than_or_equal_to {
    my ( $self, $other ) = @_;
    $self->less_than($other) || $self->equal_to($other);
}

package Printable;
use Moose::Role;
# mit requires 'to_string' wird festgelegt, dass 'Printable' diese Subroutine
# zum Arbeiten beötigt. Da US::Currency aber die 'with' Zeile mit 'Printable'
# enthält, steht diese Methode über 'US::Currency' zur Verfügung.
requires 'to_string';

package US::Currency;
use Moose;
# mit 'with' wird die Rolle von 'Comparable' übernommen und somit alle seine
# Subroutinen.
with 'Comparable', 'Printable';

has 'amount' => ( is => 'rw', isa => 'Num', default => 0 );

sub compare {
    my ( $self, $other ) = @_;
    $self->amont <=> $other->amount;
}

sub to_string {
    my $self = shift;
    sprintf '$%0.2f USD' => $self->amount;
}
