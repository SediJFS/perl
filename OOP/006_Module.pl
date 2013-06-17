#!/usr/bin/env perl

use strict;
use warnings;

# Verwendung von Math::BigInt rein Objektorientiert.
use Math::BigInt;
# Aufruf mit 'new' zum Anlegen einer neuen Instanz.
my $value = Math::BigInt->new( 2 ); # Mit 2 beginnen
# Methodenaufruf über die angelegte Instanz.
$value->bpow(1000);                 # 2 ^ 1000 (2 hoch 1000) berechnen
print $value->bstr(), "\n";         # Ergebnis ausgeben
