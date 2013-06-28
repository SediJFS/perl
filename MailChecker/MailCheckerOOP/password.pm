#!/usr/bn/env perl

package password;

use strict;
use warnings;

sub new {
    my $class = shift;
    my @params = @_;
    # Klasse durch aktuellen Packagenamen festlegen:
    unless ( $class ) {
        $class = __PACKAGE__;
    }
}

sub get_passphrase {
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
