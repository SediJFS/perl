#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Datum: 2013/04/07
# IMAP Mail Checker mit SSL

use strict;
use warnings;

# Bibliothek für IMAP mit SSL laden.
# Das Paket libnet-imap-simple-ssl-perl muss installiert sein!
use Net::IMAP::Simple;
use Net::IMAP::Simple::SSL;
use Term::ReadKey;
use Email::Simple;

# Zugangsdaten abfragen
my $server = 'imap.gmail.com';
# Benutzername
print( "Bitte geben Sie Ihre Googlemail-Adresse ein: \n" );
my $user = <STDIN>;
chomp( $user );
# Passwort
my $pass = &getpassphrase;
chomp( $pass );

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
print( "Die letzten 3 Mails waren von: \n" );
for ( my $i = 1 ; $i <= $nm ; $i++ ) {
    if( $i == $nm || $i == $nm - 1 || $i == $nm - 2) {
        my $es = Email::Simple->new( join '', @{ $imap->top($i) } );
        print( $es->header('From'), "\n" );
    } else {
        next;
    }
}

# Verbindung zum IMAP-Konto wieder trennen.
$imap->quit();

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
