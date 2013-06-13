#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Datum: 2013/04/07
# IMAP Mail Checker mit SSL für conky

use strict;
use warnings;

# use Log::Log4perl qw( :easy );
# Log::Log4perl->easy_init( $DEBUG );
# Bibliothek für IMAP mit SSL laden.
# Das Paket libnet-imap-simple-ssl-perl muss installiert sein!
use Net::IMAP::Simple;
use Net::IMAP::Simple::SSL;
use Term::ReadKey;
use Email::Simple;

#Zugangsdaten hier eintragen
# Serveradresse
my $server = '<yourSSL-IMAPServer>';
# Emailadresse
my $user = '<yourEmail>';
# Passwort
my $pass = '<yourPassword>';

# Neue Instanz des SSL-Objektes anlegen mit $server als übergebenem Parameter.
my $imap = Net::IMAP::Simple::SSL->new( $server );
# Verbindung zum IMAP-Konto herstellen.
$imap->login( $user => $pass );
# Mails aus Posteingang abrufen und ungelesene zählen.
my $messages = $imap->search_unseen( 'INBOX' );

# Mails in Posteingang abrufen
my $nm = $imap->select('INBOX');

# Ausgabe
# Anzahl ungelesener Nachrichten
print( "\nUngelesen: ", $messages, "\n" );
# Die letzten 3 Absender ausgeben
print( "--------------\n" );
print( "letzte 5: \n" );
my @mails;
for ( my $i = 1 ; $i <= $nm ; $i++ ) {
    if( $i == $nm || $i == $nm - 1 || $i == $nm - 2 || $i == $nm - 3 || $i == $nm - 4) {
        my $es = Email::Simple->new( join '', @{ $imap->top($i) } );
        push( @mails, $es->header('From'), "\n--> " );
        push( @mails, $es->header('Date'), "\n" );
    } else {
        next;
    }
}
print reverse(@mails);
# Verbindung zum IMAP-Konto wieder trennen.
$imap->quit();
