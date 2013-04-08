#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Datum: 2013/04/07
# IMAP Mail Checker mit SSL

use strict;
use warnings;

use Log::Log4perl qw( :easy );
Log::Log4perl->easy_init( $DEBUG );
# Bibliothek für IMAP mit SSL laden.
# Das Paket libnet-imap-simple-ssl-perl muss installiert sein!
use Net::IMAP::Simple;
use Net::IMAP::Simple::SSL;
use Term::ReadKey;

my $server = 'imap.gmail.com';

print( "GMail username: " );
my $user = <STDIN>;
chomp( $user );
# print( "\nBitte geben Sie ihr Googlemail Passwort ein: \n" );
my $pass = &getpassphrase();
chomp( $pass );

# Neue Instanz des SSL-Objektes anlegen mit $server als übergebenem Parameter.
my $imap = Net::IMAP::Simple::SSL->new( $server ) 
	or LOGDIE "Fehler: errstr\n";
# Verbindung zum IMAP-Konto herstellen.
$imap->login( $user => $pass ) 
	or LOGDIE "keine verbindung: errstr\n";
# Mails aus Posteingang abrufen.
my $messages = $imap->select( 'INBOX' );
# ungelesene Nachrichten zählen.
my $count = 0;
	for my $msg (1..$messages) {
		$count++ unless $imap->seen($msg);
	}
# Verbindung zum IMAP-Konto wieder trennen.
$imap->quit();

# Ausgabe 
print( "\nUngelesen: ", $count, "\n" );

sub getpassphrase {
	print "enter passphrase: ";
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
