package Restartable;
use Moose::Role;

has 'is_paused' => (
    is      => 'rw',
    isa     => 'Bool',
    default => 0,
);

requires 'save_state', 'load_state';

sub stop { 1 }

sub start { 1 }

package Restartable::ButUnreliable;
use Moose::Role;
# mit 'with' wird die Rolle von 'Restartable' übernommen und somit auch seine
# beiden Methoden 'start' und 'stop'.
# Anschließend wird per alias wird auf die beiden Methoden von 'Restartable'
# zugegriffen. Da 'alias' nur Namen hinzufügt muss anschließend mit 'exclude'
# der alte Name entfernt werden.
# Dadurch hat jede Klasse eine eigene Version von 'stop' und 'start'.
with 'Restartable' => {
    -alias => {
        stop    => '_stop',
        start   => '_start'
    },
    -excludes => [ 'stop', 'start' ],
};

sub stop {
    my $self = shift;

    $self->explode() if rand(1) > .5;

    self->_stop;
}

sub start {
    my $self = shift;

    $self->explode() if rand(1) > .5;

    self->_start;
}

package Restartable::ButBroken;
use Moose::Role;

with 'Restartable' => { -excludes => [ 'stop', 'start' ] };

sub stop {
    my $self = shift;

    $self->explode();
}

sub start {
    my $self = shift;

    $self->explode();
}
