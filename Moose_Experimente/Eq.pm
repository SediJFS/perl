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
