#!/usr/bin/env perl

package BinaryTree;
use Moose;

has 'node' => ( is => 'rw', isa => 'Any' );

has 'parent' => (
    is        => 'rw',
    isa       => 'BinaryTree',
    predicate => 'has_parent',
    weak_ref  => 1,
);

has 'left' => (
    is        => 'rw',
    isa       => 'BinaryTree',
    predicate => 'has_left',
    lazy      => 1,
    default   => sub { BinaryTree->new( parent => $_[0] ) },
    trigger   => \&_set_parent_for_child
);

has 'right' => (
    is        => 'rw',
    isa       => 'BinaryTree',
    predicate => 'has_right',
    lazy      => 1,
    default   => sub { BinaryTree->new( parent => $_[0] ) },
    trigger   => \&_set_parent_for_child
);

sub _set_parent_for_child {
    my ( $self, $child ) = @_;

    confess "You cannot insert a tree which already has a parent"
        if $child->has_parent;

    $child->parent($self);
}
