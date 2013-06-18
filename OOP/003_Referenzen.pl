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
    my @missing = ();
    for my $item (@required) {
        # Dereferenzierung der Referenz auf das ursprüngliche Array
        unless (grep $item eq $_, @$items) { # nicht in der Liste gefunden?
                push @missing, $item;
            }
        }
    if (@missing) {
        print "Adding @missing to @$items for $who.\n";
        push @$items, @missing;
    }
}
# Arrays definieren
my @skipper = qw(blue_shirt hat jacket preserver sunscreen);
my @skipper_with_name = ("Skipper", \@skipper);
my @professor = qw(sunscreen water_bottle slide_rule batteries radio);
my @professor_with_name = ("Professor", \@professor);
my @gilligan = qw(red_shirt hat lucky_socks water_bottle);
my @gilligan_with_name = ("Gilligan", \@gilligan);

my @all_with_names = (
    \@skipper_with_name,
    \@professor_with_name,
    \@gilligan_with_name,
);

# Subroutine aufrufen
# Dabei das Array jeweils über eine Referenz ansprechen
for my $person (@all_with_names) {
    my $who = $$person[0];
    my $provisions_reference = $$person[1];
    check_required_items($who, $provisions_reference);
}
# vereinfachte Schreibweise:
for my $person (@all_with_names) {
    check_required_items(@$person);
}

# alter Aufruf vor mehrdimensionaler Arrayreferenz
#~ check_required_items("professor", \@professor);
#~ check_required_items("skipper", \@skipper);
#~ check_required_items("gilligan", \@gilligan);
