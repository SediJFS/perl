package Dog;

use Moose;

extends 'Animal';

has '+attackPower' => ( default => 10 );
has 'sound' => ( is => 'rw', isa => 'Str', default => 'Woof' );

sub bite {
    my $self = shift;
    $self->{attackPower} = $self->{attackPower} + 5;
    return $self->{attackPower};
}

1;
