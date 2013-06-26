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
    my @params = @_;

    # Fallback: Klasse durch aktuellen Packagenamen festlegen:
    unless ( $class ) {
        $class = __PACKAGE__;
    }
}

# Subroutine um Passworteingabe mit Sternchen zu überschreiben.
sub getpassphrase {
    print "\nBitte geben Sie ihr Googlemail Passwort ein: \n";
    ReadMode 'raw';
    my $passphrase;
    while (1) {
        my $key .= (ReadKey 0);
        if ($key ne "\n") {
            print '*';
            $passphrase .= $key
        } else {
            last
        }
    }
    ReadMode 'restore';
    return $passphrase
}
