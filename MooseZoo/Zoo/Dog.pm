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

sub play_ball {
    my $self = shift;
    if ( $self->{energy} <= 5 && $self->{energy} <= 20 ) {
        $self->{energy} = $self->{energy} + 5;
    }
}

1;
