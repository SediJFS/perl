#!/usr/bin/env perl

package My::IO;

use Moose;
use MooseX::GlobRef;

use Log::Log4perl qw( :easy );
Log::Log4perl->easy_init( $DEBUG );

has 'file' => ( 
    is          => 'ro',
    isa         => 'Str',
    required    => 1
);

#######################################################################
# Subroutine zum Öffnen des Filehandles                               #
# Bekommt Pfad zur Datei als Parameter                                #
sub open {                                                            #
#######################################################################
    my $fh = shift;
    open $fh, $fh->file or confess "cannot open";
    return $fh;
}

#######################################################################
# Subroutine zum lesen des Dateiinhalts                               #
sub getlines {                                                        #
#######################################################################
    my $fh = shift;
    return readline $fh;
}

print "Bitte geben Sie den Dateipfad an: ";
my $path = <STDIN>;
chomp( $path );
DEBUG $path;
my $io = My::IO->new( file => $path );
print "::::::FILE:::::::\n";
print $io->file, "\n";
print "::::::BEGIN::::::\n";
$io->open;
print $io->getlines;
print "::::::END::::::::\n";
