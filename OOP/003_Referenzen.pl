#!/usr/bin/env perl

use strict;
use warnings;

#~ my @required = qw(preserver sunscreen water_bottle jacket);
#~ my @skipper = qw(blue_shirt hat jacket preserver sunscreen);
#~ for my $item (@required) {
    #~ unless (grep $item eq $_, @skipper) { # nicht in der Liste gefunden?
        #~ print "skipper is missing $item.\n";
    #~ }
#~ }

# um nicht für jedes Crew-Mitglied den selben Code schreiben zu müssen:
sub check_required_items {
    my $who = shift;
    my $items = shift;
    my @required = qw(preserver sunscreen water_bottle jacket);
    for my $item (@required) {
        unless (grep $item eq $_, @_) { # nicht in der Liste gefunden?
                print "$who is missing $item.\n";
            }
        }
}
# Arrays definieren
my @skipper = qw(blue_shirt hat jacket preserver sunscreen);
my @professor = qw(sunscreen water_bottle slide_rule batteries radio);
my @gilligan = qw(red_shirt hat lucky_socks water_bottle);
# Subroutine aufrufen
# Dabei das Array jeweils über eine Referenz ansprechen
check_required_items("professor", \@professor);
check_required_items("skipper", \@skipper);
check_required_items("gilligan", \@gilligan);
