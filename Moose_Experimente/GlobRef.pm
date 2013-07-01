#!/usr/bin/env perl

package My::IO;

use Moose;
use MooseX::GlobRef;

has 'file' => ( 
    is          => 'ro',
    isa         => 'Str',
    required    => 1
);

sub open {
    my $fh = shift;
    open $fh, $fh->file or confess "cannot open";
    return $fh;
}

sub getlines {
    my $fh = shift;
    return readline $fh;
}

my $io = My::IO->new( file => '/etc/passwd' );
print "::::::::::::::\n";
print $io->file, "\n";
print "::::::::::::::\n";
$io->open;
print $io->getlines;
