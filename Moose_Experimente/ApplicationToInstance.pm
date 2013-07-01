package MyApp::Role::Job::Manager;

use List::Util qw( first );

use Moose::Role;

has 'employees' => (
    is => 'rw',
    isa => 'ArrayRef[Employee]',
);

