# Sammlung nützlicher Subroutinen in Perl
# Author: Josef Sedlmeier

package JS_Tools;

use base qw( Exporter );

@EXPORT_OK = qw(
    csv
    getDate
    arrayEingabe
    db_connect
    db_disconnect
    email_pruefen
    getpassphrase
);
@EXPORT = @EXPORT_OK;

use strict;
use warnings;

use Log::Log4perl qw( :easy );
Log::Log4perl->easy_init( $DEBUG );

use DBI;
use lib '/usr/share/perl5/Email';
use Email::Valid;
use Term::ReadKey;

use Mail::RFC822::Address qw(valid validlist);

###################################################################
# CSV Subroutine. Liest ein array ein und gibt eine CSV aus.
sub  csv {
###################################################################
	my $csvEintraege = join (",", @_);
	return $csvEintraege;
    }
    
###################################################################
# getDate Subroutine. Liest aus der Datenbank das aktuelle Datum aus und gibt es in deutschem 
# Datumsformat zurück     
sub getDate {																							        
###################################################################
	
	my $dbh = &get_dbHandle();
	my $datum_iso = $dbh->selectall_arrayref(
		"SELECT TO_CHAR( CURRENT_DATE, 'YYYY-MM-DD' )"
	    )->[0]->[0];

	$datum_iso =~ m{(?<Jahr>\d\d\d\d)-(?<Monat>\d\d)-(?<Tag>\d\d)};
	my $datumDeutsch = sprintf("%02d.%02d.%04d.\n", $+{'Tag'}, $+{'Monat'}, $+{'Jahr'});

	return $datumDeutsch;

}

###################################################################
# arrayEingabe Subroutine. Bekommt ein Benutzereingabe mit Leerzeichen getrennter Zeichen
# und wandelt diese in ein Array um
sub arrayEingabe  {
###################################################################
my @newArray;

my $Eingabe = <STDIN>;
	@newArray = split(/ /,  $Eingabe);
	return @newArray;
}

###################################################################
# db_connect. öffnet die Verbindung zur lokalen  PostgreSQL Datenbank. liefert das DB-Handle zurück
sub db_connect {                                         													 
###################################################################
use DBI; # sicherheitshalber (nochmal) "vor Ort"
    # mit PostgreSQL verbinden: 
    my $dbh = DBI->connect(
        'dbi:Pg:' . join(
            ';',
            qw(
                host=localhost
                dbname=kurs
                sslmode=require
            )
        ),
        'kurs',
        'kurs',
        {
            AutoCommit => 0,
            RaiseError => 1,
            PrintError => 0,
            pg_server_prepare => 1,
        }
    ) or LOGDIE $DBI::errstr;
    # Database-Handle zurückliefern:
    return $dbh;
}

###################################################################
# get dbHandle. öffnet die Verbindung zur PostgreSQL Datenbank lokal.
sub db_disconnect {                                         													 
###################################################################
	
	get_dbHandle->disconnect() or LOGDIE get_dbHandle->errstr;
	return 1;
}

###################################################################
# prüft, ob eine email einem bestimmten Suchmuster entspricht.
sub email_pruefen {
###################################################################
    
    my $email = shift;
    chomp($email);

    
# Lösung mit Email::Valid
    return (Email::Valid->address($email) ? 'valid' : 'invalid');
       
# Lösung mit Mail::RFC822::Address    
        # if (valid($email)) {
                # print "Email valid!"
            # }
        # else {
                # print "Email invalid!"
            # }

# Lösungsansatz mit eigenem RegEx (funktioniert nicht!!!)
    # if ($email !~ m{ ^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$ }) {
            # print "Email valid!";
        # }
    # else {
            # print "Email invalid!";
        # }
}

###################################################################
# passworteingabe mit sternchen ersetzen. benutzt use Term::ReadKey; 
sub getpassphrase {
###################################################################	
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

1; 	#make perl happy!