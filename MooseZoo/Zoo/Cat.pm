package Cat;
use strict;
use Moose;

extends 'Animal';

has '+attackPower' => ( default => 12 );
has 'sound' => ( is => 'rw', isa => 'Str', default => 'Meow' );

sub claw{
    my $self = shift;
    $self->{attackPower} = $self->{attackPower} + 10;
    return $self->{attackPower};
}

1;