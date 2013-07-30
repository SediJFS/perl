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
    my $fainted = 0;
    
    if ( $fainted == 1 ) {
        return 'enemy fainted';
    } else {
        my $enemyAttack = $_[0]->{attackPower};
        my $selfAttack = $self->{attackPower};
        if ( $enemyAttack > $selfAttack ) {
            $self->{fainted} = 1;
            return $_[0]->{name};
        } elsif ( $enemyAttack == $selfAttack ) {
            return 'draw';
        }else {
            $_[0]->{fainted} = 1;
            $self->{lastWin} = 1;
            return $self;
        }
    }
}

sub check_energy {
    my $self = shift;
    if ( $self->{energy} <= 0 ) {
        $self->{fainted} == 1;
    } else {
        $self->{fainted} == 0;
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