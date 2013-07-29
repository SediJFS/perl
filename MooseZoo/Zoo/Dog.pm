package Dog;

use Moose;

extends 'Animal';

has '+attackPower' => ( default => 10 );
has 'sound' => ( is => 'rw', isa => 'Str', default => 'Woof' );

1;
