package Animal;
use strict;

use Moose;

has 'name'          => ( is => 'rw', isa => 'Str', required => 1 );
has 'attackPower'   => ( is => 'rw', isa => 'Int', default => 5 );

sub fight {
    my $self = shift( @_ );
    my $animal1 = $_[0];
    my $animal2 = $_[1];
    my $winner = "";
    if ( $animal1->AttackPower > $animal2->AttackPower ) {
        $winner = $animal1->Name;
    } elsif ( $animal1->AttackPower == $animal2->AttackPower ){
        return "draw";
        exit;
    } else {
        $winner = $animal2->Name;
    }
    return $winner;
}

sub speak {
    my $self = shift;
    my $name = $self->{name};
    my $sound = $self->{sound};
    return $name . " says " . $sound;
}

1;