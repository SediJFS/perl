package Animal;
use strict;

use Moose;

# Bequemes Loggen:
use Log::Log4perl qw( :easy );
Log::Log4perl->easy_init( $DEBUG );

has 'name'          => ( is => 'rw', isa => 'Str', required => 1 );
has 'attackPower'   => ( is => 'rw', isa => 'Int', default => 5 );

sub fight {
    my $self = shift( @_ );
    
    my $enemyAttack = $_[0]->{attackPower};
    my $selfAttack = $self->{attackPower};
    if ( $enemyAttack > $selfAttack ) {
        return $_[0]->{name};
    } else {
        return $self;
    }
}

sub speak {
    my $self = shift;
    my $name = $self->{name};
    my $sound = $self->{sound};
    return $name . " says " . $sound;
}

1;