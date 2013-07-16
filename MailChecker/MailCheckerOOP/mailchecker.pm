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

# Zugriff auf IMAP über SSL
use Net::IMAP::Simple::SSL;

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
    # Atribute
    $self->{SERVER} = 'imap.googlemail.com';
    $self->{USER}   = 'diskilla@gmail.com';
}

sub get_mail {
    
}

sub open_imap {
    my $self   = shift;
    my @params = @_;
    my $server = $_[0];
    my $user   = $_[1];
    my $imap   = Net::IMAP::Simple::SSL->new( $server );
    return $imap;
}

# make perl happy
1;
