package BeispielKlasse;

use strict;
use warnings;

# Bequemes Loggen:
use Log::Log4perl qw( :easy );
Log::Log4perl->easy_init( $DEBUG );

# Liste der erlaubten Attributnamen als Klassenvariable:
our @allowedAttributeNames;

#####################################################################
# Hier beginnen die Methoden


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

    # neues Objekt (Datenstruktur: Hashreferenz):
    my $self = {};

    # frisch "gebackenes" Objekt an Klasse binden, damit es weiß,
    # was es ist, hat und kann
    bless( $self, $class );

    # Attributnamensliste erweitern:
    $self->extend_allowedAttributeNames(
        qw(
            StartTimestamp
        )
    );

    # Attribut-Defaultwerte definieren:
    $self->StartTimestamp( scalar( localtime ) );

    # übergebene Parameter für die Initialisierung des Objekts verwenden:
    if ( @params ) {
        # Setter-Methode verwenden, damit nur "erlaubte" Attribute gesetzt werden:
        $self->set( @params );
    }

    # neues Objekt zurück liefern:
    $self;
}

# Perl-OOP-technische Methoden, die also keine spezielle Funktionalität
# dieser Klasse implementieren:

#####################################################################
#                                                                   #
# Objekt-Destruktor (u.a. Abbau der DB-Verbindung):                 #
#                                                                   #
sub DESTROY { # der Name "DESTROY" des Destruktors ist fix!         #
#                                                                   #
#####################################################################
    my $self = shift; # Objekt
    1;  # Dummy
}


#####################################################################
#                                                                   #
# Klassen-Destruktor                                                #
#                                                                   #
sub END {                                                           #
#                                                                   #
#####################################################################
    1;  # Dummy
}

#####################################################################
#                                                                   #
# allgemeiner Setter (kann mehrere Attribute auf einmal setzen,     #
# verwendet intern den AUTOLOADer)                                  #
sub set {                                                           #
#                                                                   #
#####################################################################
    my $self  = shift; # Objekt

    # Attribute und ihre Werte schreiben
    my %attributes = ();

    if ( ref( $_[ 0 ] eq 'HASH' ) ) { # Erhalten wir die Attribute als Referenz auf einen Hash ...
        %attributes = %{ $_[ 0 ] };
    }
    elsif ( ref( $_[ 0 ] eq 'ARRAY' ) ) { # ... oder als Referenz auf eine Liste ...
        %attributes = @{ $_[ 0 ] };
    }
    else { # ... oder als Liste (abwechselnd jeweils Attribut-Name und -Wert)?
        %attributes = @_;
    }

    # alle Attribute durchlaufen und im Objekt speichern:
    while ( my ( $attr, $wert ) = each( %attributes ) ) {
        my $retVal = eval( '$self->set_' . $attr . '( $wert )' );
        unless ( defined( $retVal ) ) {
            LOGDIE "Setter für Attribut '$attr' fehlgeschlagen: $@";
        }
    }

    # mit (neuen) Attributen/-werten gefülltes Objekt zurückliefern:
    return $self;
}


#####################################################################
#                                                                   #
# allgemeiner Getter (kann mehrere Attribute auf einmal auslesen)   #
#                                                                   #
sub get {                                                           #
#                                                                   #
#####################################################################
    my $self  = shift; # Objekt

    # Attribute auslesen
    my @attributeNames = ();

    if ( ref( $_[ 0 ] eq 'ARRAY' ) ) { # Erhalten wir die Attributnamen als Referenz auf eine Liste ...
        @attributeNames = @{ $_[ 0 ] };
    }
    else { # ... oder als Liste?
        @attributeNames = @_;
    }

    # alle Attribute durchlaufen und Werte zwischenspeichern:
    my @attributeValues = ();
    foreach my $attr ( @attributeNames ) {
        my $retVal = eval( '$self->get_' . $attr . '()' );
        unless ( defined( $retVal ) ) {
            LOGDIE "Setter für Attribut '$attr' fehlgeschlagen: $@";
        }
        else {
            push( @attributeValues, $retVal );
        }
    }

    # die gewünschten Attributwerte als Liste oder Arrayreferenz zurückliefern:
    return (
        wantarray()
            ?  @attributeValues
            : \@attributeValues
    );
}

#####################################################################
#                                                                   #
# automatisiert Zugriffsmethoden (Getter/Setter) implementieren:    #
#                                                                   #
sub AUTOLOAD { # automatische Implementierung von Methoden          #
               # (wird nur bei Bedarf/Verwendung gemacht)           #
#                                                                   #
#####################################################################
    our $AUTOLOAD; # Variable, die die aufgerufene Methode enthält (muss mit "our" zur Package-globalen Variablen gemacht werden)
    # den Packagenamen entfernen, um den "reinen" Namen der Methode zu erhalten
    ( # damit die Zuweisung vor dem Suchen/Ersetzen ausgeführt wird
        my $methode = $AUTOLOAD
    ) =~ s{ # Package-Namen entfernen:
        .*    # der Packagename
        ::    # das Trennzeichen zwischen Packagenamen und dem Namen der Subroutine
    }{}xs;  # durch nichts ersetzen (also entfernen)
    #
    # Für Setter gilt: (potenzieller) Attributname = Methodenname ohne "set_" am Anfang,
    # außerdem soll als Getter auch "get_..." erlaubt sein.
    ( # damit die Zuweisung vor dem Suchen/Ersetzen ausgeführt wird
        my $attributname = $methode
    ) =~ s{ ^ (?: s|g ) et_ }{}x;
    #
    if ( # Handelt es sich um ein bekanntes/"erlaubtes" Attribut?
        grep {
            $attributname eq ucfirst( $_ )
        } (
            @allowedAttributeNames
        )
    ) { # eine der bekannten Zugriffsmethoden wird aufgerufen
        $attributname = ucfirst( $attributname ); # der Attributname fängt mit Großbuchstaben an
        #
        # der nachfolgende Perl-Code-Block ist ein sog. "Closure" (siehe z.B. http://perldoc.perl.org/perlfaq7.html#What%27s-a-closure? und http://perldoc.perl.org/perlref.html)
        { # Beginn Closure
            no strict qw( refs );
            if ( substr( $methode, 0, 4 ) ne 'set_' ) { # (wahrscheinlich) Getter? (substr() ist effizienter als ein RegEx und hier genauso gut!)
                # die folgende Zeilen sind "Perl-Magie" ;-)
                *{ $AUTOLOAD } = sub { # auf der linken Seite der Zuweisung: Glob-Notation ("alle Perl-Dinge mit diesem Namen", d.h. der Skalar, das Array, der Hash, die Subroutine, das Filehandle etc.pp. mit dem entsprechenden Namen)
                    # es könnte doch ein Setter sein, nämlich dann, wenn ein Argument geliefert wird:
                    if ( @_ > 1 ) { # Setter!
                        my $retVal = eval( '$_[ 0 ]->set_' . $attributname . '( $_[ 1 ] )' );   # neuen Attributwert zuweisen
                        unless ( defined( $retVal ) ) {
                            LOGDIE "Setter für Attribut '$attributname' fehlgeschlagen: $@";
                        }
                        $_[ 0 ];                                    # geändertes Objekt zurückliefern
                    }
                    else { # eindeutig Getter!
                        $_[ 0 ]->{ $attributname }; # Attributwert auslesen und zurückliefern
                    }
                };
            }
            else { # Setter!
                *{ $AUTOLOAD } = sub {
                    $_[ 0 ]->{ $attributname } = $_[ 1 ];   # neuen Attributwert zuweisen
                    $_[ 0 ];                                    # geändertes Objekt zurückliefern
                };
            }
        } # Ende Closure
        goto &{ $AUTOLOAD }; # hier wird "goto" sinnvoll eingesetzt und ist damit "erlaubt"
    }
    #
    # wenn wir hierher gelangt sind, ist die Methode nicht bekannt/implementiert => töten!
    LOGDIE $_[ 0 ] . " versteht $methode nicht.";
} # Ende AUTOLOAD

#####################################################################
# hier beginnen die für die Klasse spezifischen Methoden            #
#####################################################################


#####################################################################
#                                                                   #
# erlaubte Attributnamen erweitern                                  #
#                                                                   #
sub extend_allowedAttributeNames {                                   #
#                                                                   #
#####################################################################
    my $selfOrClass = shift;

    push(
        @allowedAttributeNames,
        @_
    );
}

#####################################################################
#                                                                   #
# Methode, um herauszufinden, ob ein bestimmter (skalarer)          #
# Wert $value in einem Array @array enthalten ist                   #
#                                                                   #
sub in_array {                                                       #
#                                                                   #
#####################################################################
    my $self = shift;    # Objekt

    # Wert übernehmen
    my $value = shift;
    # restliche Parameter übernehmen
    my @testArray = @_;

    # falls es sich dabei um eine Arrayreferenz handelt,
    # diese dereferenzieren
    if ( ref( $testArray[ 0 ] ) eq "ARRAY" ) {
        @testArray = @{ $testArray[ 0 ] };
    }

    # "Gleichheit": "alphanumerisch oder numerisch gleich"
    {
        # für diesen einen Block lang die Warnungen wegen "=="
        # ausschalten, wenn ein Operand nicht numerisch
        # oder ein zu testender Wert nicht definiert ist
        no warnings qw( numeric uninitialized );

        return (
            scalar (
                grep {
                    ( $_ eq $value )
                    or
                    (
                        m/ ^ \s* \d+ \s* $ /ox
                        and
                        ( $_ == $value )
                    )
                } ( @testArray )
            )
            ? 1
            : 0
        );
    }
}


#####################################################################
#                                                                   #
# Methode, um alle Dubletten aus einem Array zu eliminieren         #
# Aufrufparameter:   Array oder Arrayreferenz                       #
# Rückgabeparameter: Kopie des Arrays (bzw. der Arrayreferenz,      #
#                    je nachdem, ob die Methode im List- oder       #
#                    skalaren Kontext aufgerufen worden ist),       #
#                    in dem aber jeder Wert nur einmal vorkommt.    #
#                                                                   #
sub select_distinct {                                               #
#                                                                   #
#####################################################################
    my $self = shift;    # Objekt

    # Array übernehmen
    my @array = @_;

    # falls es sich dabei um eine Arrayreferenz handelt,
    # diese dereferenzieren
    if (ref( $array[ 0 ] ) eq "ARRAY") {
        @array = @{ $array[ 0 ] };
    }

    # Über den Umweg eines Hashes die Dubletten entfernen,
    # dabei die ursprüngliche Reihenfolge beibehalten
    # Das umgekehrte Durchlaufen von @array beim Aufbau von
    # %localHash sorgt dafür, dass die Dublette an der Stelle
    # ihres ersten Auftretens einsortiert wird...
    my %localHash = map {
            ( $array[ $#array - $_ ] => ( $#array - $_ ) )
        } (
            0 .. $#array
        )
    ;
    @array = sort {
            $localHash{$a} <=> $localHash{$b}
        } (
            keys( %localHash )
        )
    ;

    if ( wantarray() ) {
        return @array;
    } else {
        return \@array;
    }
}


# Hier enden die Methoden
#####################################################################

# Make Perl happy
1;