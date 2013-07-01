#!/usr/bin/env perl

package MyApp::Role::Job::Manager;

use List::Util qw( first );

use Moose::Role;

has 'employees' => (
    is => 'rw',
    isa => 'ArrayRef[Employee]',
);

sub assign_work {
    my $self = shift;
    my $work = shift;

    my $employee = first { !$_->has_work } @{ $self->employees };

    die 'all my employees have work to do!' unless $employee;

    $employee->work($work);
}

package main;

my $lisa = Employee->new( name => 'Lisa' );
MyApp::Role::Job::Manager->meta->apply($lisa);

my $bart = Employee->new( name => 'Bart' );
my $homer = Employee->new( name => 'Homer' );
my $marge = Employee->new( name => 'Marge' );

$lisa->employees( [ $homer, $bart, $marge ] );
$lisa->assign_work('mow the lawn');
