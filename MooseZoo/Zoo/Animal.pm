package Animal;
use strict;

use Moose;

# Bequemes Loggen:
use Log::Log4perl qw( :easy );
Log::Log4perl->easy_init( $DEBUG );

# Klassenattribute
has 'name'          => ( is => 'rw', isa => 'Str' ,                required => 1 );
has 'attackPower'   => ( is => 'rw', isa => 'Int' , default => 5                 );
has 'energy'        => ( is => 'rw', isa => 'Int' , default => 10, required => 1 );
# Attribute für Flags
has 'fainted'       => ( is => 'rw', isa => 'Bool', default => 0                 );
has 'lastWin'       => ( is => 'rw', isa => 'Bool', default => 0                 );

# Klassenmethoden
sub fight {
    my $self = shift( @_ );
    my $enemy = $_[0];
    if ( $self->{energy} <= 0 ) {
        return $self->speak . '\n' . $self->{name} . ' fainted';
    } elsif ( $enemy->{energy} <= 0 ) {
        return $enemy->speak . '\n' . $enemy->{name} . ' fainted';
    } else {
        my $enemyAttack = $_[0]->{attackPower};
        my $selfAttack = $self->{attackPower};
        if ( $enemyAttack > $selfAttack ) {
            $self->{energy} = $self->{energy} - 1;
            return $self->{energy};
        } elsif ( $enemyAttack == $selfAttack ) {
            return $self->{energy};
        }else {
            $enemy->{energy} = $enemy->{energy} - 1;
            return $self->{energy};
        }
    }
}

sub check_energy {
    my $self = shift;
    if ( $self->{energy} <= 0 ) {
        $self->{fainted} == 1;
    }
}

sub check_state {
    my $self = shift;
    if ( $self->{lastWin} == 1 ) {
        return 1;
    } else {
        return 0;
    }
}

sub speak {
    my $self = shift;
    my $name = $self->{name};
    my $sound = $self->{sound};
    return $name . " says " . $sound;
}

1;