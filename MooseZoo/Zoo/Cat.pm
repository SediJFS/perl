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

sub play_kill {
    my $self = shift;
    if ( $self->{energy} <= 5 && $self->{energy} <= 20 ) {
        $self->{energy} = $self->{energy} + 4;
    }
}

1;