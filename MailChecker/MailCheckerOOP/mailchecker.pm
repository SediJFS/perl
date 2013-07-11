#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Datum: 2013/06/26
# IMAP OOP Mail Checker mit SSL

package mailchecker;

use strict;
use warnings;

# Bequemes Loggen:
use Log::Log4perl qw( :easy );
Log::Log4perl->easy_init( $DEBUG );

# OOP-Zugriff auf Dateien:
use IO::File;


#####################################################################
#                                                                   #
# Konstruktor                                                       #
#                                                                   #
sub new {                                                           #
#                                                                   #
#####################################################################
    my $class = shift;
    my $self = {};
    my @params = @_;
    bless($self, $class);
    return $self;
}

sub get_mail {
    
}
