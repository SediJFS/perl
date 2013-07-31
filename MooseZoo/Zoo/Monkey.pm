package Monkey;
use strict;

use Moose;

extends 'Animal';

has '+attackPower' => ( default => 15 );
has 'sound' => ( is => 'rw', isa => 'Str', default => 'WhoWhoWho' );

sub strangle {
    my $self = shift;
    $self->{attackPower} = $self->{attackPower} * 2;
    return $self->{attackPower};
}

sub strangle_with_both_hands {
    my $self = shift;
    $self->{attackPower} = $self->{attackPower} * 4;
    return $self->{attackPower};
}

1;