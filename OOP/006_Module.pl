#!/usr/bin/env perl

use strict;
use warnings;

use Math::BigInt;
my $value = Math::BigInt->new( 2 ); # Mit 2 beginnen
$value->bpow(1000);                 # 2 ^ 1000 (2 hoch 1000) berechnen
print $value->bstr(), "\n";         # Ergebnis ausgeben
