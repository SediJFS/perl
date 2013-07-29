package Animal;
use strict;

use Moose;

has 'Name'          => ( is => 'rw', isa => 'Str', required => 'true' );
has 'AttackPower'   => ( is => 'rw', isa => 'Int', default => 5 );

sub Fight {
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

1;