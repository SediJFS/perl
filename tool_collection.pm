#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Sammlung nützlicher Module für Perl

package tool_collection;
#
use Exporter;
@ISA = ('Exporter');

@EXPORT_OK = qw/
    OrvStrGetCode
    OrvStrGetDecode
    TimeStamp
    UpperCaseWithoutSz
    UpperCase
    LowerCase
    Str2Num
    Num2Betr
    Path2File
    Path2Dir
    Path2DirUnix
    SuperDir
    SuperDirUnix
/;
@EXPORT = @EXPORT_OK

#####################################################################
#### Aus FG_tools.pm von Frank Gard #################################
#
sub OrvStrGetCode {
    my $warmesWuerstchen = $_[0];$kaltesWuerstchen = "";
    my $warmString = 'fMHgOhjlL0mGInXYbpN5iyzAcoCaD8tEFJeqKPkQRrSTU9VWs2uwZ1v3d4B6x7';
    my $kaltString = 'UuEavF6lAXC1wmbK23kMBnjR9ciWGoQsh5pxHPZrdyg84DIzfYT7JeLS0NtVOq';
    my @warmesWuerstchenField = split("",$warmesWuerstchen);
    my @warmStringField = split("",$warmString);
    my @kaltStringField = split("",$kaltString);
    my %warmPosHash = ();
    for ($i=0; $i<=$#warmStringField; $i++) {
        $warmPosHash{$warmStringField[$i]} = $i
        }
    for ($i=0; $i<=$#warmesWuerstchenField; $i++) {
        my $kaltPos = 0;my $kaltChar = "";
        if (exists($warmPosHash{$warmesWuerstchenField[$i]})) {
            $kaltPos=$warmPosHash{$warmesWuerstchenField[$i]
            }+&getPosUmrechnungOrvStrGetCode($i);
            if ($kaltPos < 0) {
                my $anz = scalar(@kaltStringField);
                my $quotient = 1 - int($kaltPos/$anz);
                $kaltPos += $quotient * $anz;
                }
            $kaltPos %= scalar(@kaltStringField);
            $kaltChar = $kaltStringField[$kaltPos];
        } else {
            do {
                warn "\ncharacter '" . $warmesWuerstchenField[$i] . "' not allowed.\n"; 
                print STDERR "\ncharacter '" . $warmesWuerstchenField[$i] . "' not allowed.\n";
            };return "";
            }
        if ($kaltChar ne "") {
            $kaltesWuerstchen .= $kaltChar
        } else {
            $kaltesWuerstchen .= $warmesWuerstchenField[$i]
            }
    }
    return $kaltesWuerstchen;
    sub getPosUmrechnungOrvStrGetCode {
        my $x = $_[0];
        my $y = 1;
        if (($x%2) == 0){$y=-1};
        return $y*($x+($x%2))/2;
    }
}

sub OrvStrGetDecode {
    my $kaltesWuerstchen = $_[0];$warmesWuerstchen = "";
    my $warmString = 'fMHgOhjlL0mGInXYbpN5iyzAcoCaD8tEFJeqKPkQRrSTU9VWs2uwZ1v3d4B6x7';
    my $kaltString = 'UuEavF6lAXC1wmbK23kMBnjR9ciWGoQsh5pxHPZrdyg84DIzfYT7JeLS0NtVOq';
    my @kaltesWuerstchenField = split("",$kaltesWuerstchen);
    my @kaltStringField = split("",$kaltString);
    my @warmStringField = split("",$warmString);
    my %kaltPosHash = ();
    for ($i=0; $i<=$#kaltStringField; $i++) {
        $kaltPosHash{$kaltStringField[$i]} = $i
        }
    for ($i=0; $i<=$#kaltesWuerstchenField; $i++) {
        my $warmPos = 0;my $warmChar = "";
        if (exists($kaltPosHash{$kaltesWuerstchenField[$i]})) {
            $warmPos=$kaltPosHash{
                $kaltesWuerstchenField[$i]
                }+&getPosUmrechnungOrvStrGetDecode($i);
            if ($warmPos < 0) {
                my $anz = scalar(@warmStringField);
                my $quotient = 1 - int($warmPos/$anz);
                $warmPos += $quotient * $anz;
                }
            $warmPos %= scalar(@warmStringField);
            $warmChar = $warmStringField[$warmPos];
        } else {
            do {
                warn "\ncharacter '" . $kaltesWuerstchenField[$i] . "' not allowed.\n"; 
                print STDERR "\ncharacter '" . $kaltesWuerstchenField[$i] . "' not allowed.\n";
            };return "";
        }
        if ($warmChar ne "") {
            $warmesWuerstchen .= $warmChar
            } else {
                $warmesWuerstchen .= $kaltesWuerstchenField[$i]
            }
    }
    return $warmesWuerstchen;
    sub getPosUmrechnungOrvStrGetDecode {
        my $x = $_[0];my $y = 1;
        unless (($x%2) == 0){$y=-1};
        return $y*($x+($x%2))/2;
    }
}

# Subroutine zur Erzeugung eines Zeitstempels
sub TimeStamp {
  # Aufruf-Parameter:
  # 1 => Ausgabe in "Logfile-Format" (DD.MM.YYYY;hh:mm:ss Sommerzeit)
  # 2 => Ausgabe in rein informativem Format (Zahlencode, YYYYMMDDhhmmssd)
  # 3 => Ausgabe in "Oracle-Format" (DD.MM.YYYY hh:mm:ss)
  # 4 => Ausgabe in Klartext (DoW MON [D]D hh:mm:ss YYYY [DST], z.B. "Fri Oct 22 17:05:05 1999 DST")
  # 5 => Ausgabe in "Oracle-Format" (2) (DD.MM.YYYY;hh:mm:ss)
  #
  my $outputMode = $_[0];
  my $Time = time;
  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($Time);
  $mon++;
  $wday++;
  $year += 1900;
  $yday++;
  # printf "Es ist jetzt %02d:%02d:%02d Uhr.\nHeute ist der %02d.%02d.%04d. Das ist der %3d-te Tag im Jahr.\n\n",$hour,$min,$sec,$mday,$mon,$year,$yday;
  # if ($isdst) {print "Wir haben Sommerzeit.\n";} else  {print "Wir haben Winterzeit.\n";}
  #
  # Zeitstempel generieren:
  if ($outputMode == 1) {
    $isdstText = "Sommerzeit" if ($isdst);
    $isdstText = "Winterzeit" unless ($isdst);
    $timeStamp = sprintf("%02d.%02d.%04d;%02d:%02d:%02d %s",$mday,$mon,$year,$hour,$min,$sec,$isdstText);
  } elsif ($outputMode == 2) {
    $timeStamp = sprintf("%04d%02d%02d%02d%02d%02d%d",$year,$mon,$mday,$hour,$min,$sec,$isdst);
  } elsif ($outputMode == 3) {
    $timeStamp = sprintf("%02d.%02d.%04d %02d:%02d:%02d",$mday,$mon,$year,$hour,$min,$sec);
  } elsif ($outputMode == 4) {
    $isdstText = "(DST)" if ($isdst);
    $isdstText = "" unless ($isdst);
    $timeStamp = scalar localtime($Time) . " $isdstText";
  } elsif ($outputMode == 5) {
    $timeStamp = sprintf("%02d.%02d.%04d;%02d:%02d:%02d",$mday,$mon,$year,$hour,$min,$sec);
  } else {
    $timeStamp = scalar localtime($Time);
  }
  # und als Rückgabewert liefern
  return $timeStamp;
}

#####################################################################
#####################################################################

# Subroutine zur Umwandlung eines Strings in einen in Großschrift ("ß" wird nicht in "SS" gewandelt, sondern beibehalten)

sub UpperCaseWithoutSz {
    my $string = $_[0];
    #
    $string =~ tr/a-zäöüáéíóúàèìòùâêîôû/A-ZÄÖÜÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛ/;
    #
    return $string;
}

# Subroutine zur Umwandlung eines Strings in einen in Großschrift ("ß" wird in "SS" gewandelt)

sub UpperCase {
    my $string = $_[0];
    #
    $string =~ tr/a-zäöüáéíóúàèìòùâêîôû/A-ZÄÖÜÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛ/;
    $string =~ s/ß/SS/g;
    #
    return $string;
}

# Subroutine zur Umwandlung eines Strings in einen in Kleinschrift

sub LowerCase {
    my $string = $_[0];
    #
    $string =~ tr/A-ZÄÖÜÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛ/a-zäöüáéíóúàèìòùâêîôû/;
    #
    return $string;
}

# Subroutine zur Umwandlung eines Strings (mit Dezimalkomma ohne Tausendertrenner) in eine Zahl

sub Str2Num {
    my $string = $_[0];
    #
    # Damit Perl auch mit Nachkommastellen richtig rechnet und der ORVIS-Import nicht beim Komma abschneidet,
    # muß für alle Zahlenfelder das Komma durch einen Punkt ersetzt werden
    $string =~ s/,/./;
    $string += 0;
    #
    return $string;    # auch wenn die Variable anderes vermuten läßt, ist das jetzt eine Zahl
}

# Subroutine zur Umwandlung einer Zahl in einen Betragsfeld-String (mit Dezimalpunkt und genau zwei Nachkommastellen)

sub Num2Betr {
    my $num = $_[0];
    #
    return sprintf("%.2f",$num);
}

# Subroutine zur Umwandlung einer Zahl (mit Dezimalpunkt) in einen Betragsfeld-String für Textfelder (mit Dezimalkomma und Tausendertrenner)

sub Betr2Str {
    my $num = $_[0];
    #
    $num =~ s/\./,/;    # Dezimalpunkt in Komma wandeln
    #
    # Tausendertrennzeichen (".") einfügen:
    while ($num =~ s#(\d)(\d{3})\b#$1.$2#) {1}
    #
    return $num;    # auch wenn die Variable anderes vermuten läßt, ist das jetzt ein String
}

# Subroutine zum Extrahieren des Dateinamens (incl. Extension) aus einem absoluten oder relativen Pfad
sub Path2File {
    my $path = $_[0];
    #
    $path =~ s#\\#/#g;    # Backslashes in Slashes wandeln
    $path =~ s#^(?:.+/)*([^/]+)$#$1#;    # Filenamen extrahieren
    #
    return $path;
}

# Subroutine zum Extrahieren des Verzeichnisnamens aus einem Pfad
sub Path2Dir {
    my $path = $_[0];
    #
    $path =~ s#\\#/#g;    # Backslashes in Slashes wandeln
    $path =~ s#^((?:.+/)*)(?:[^/]+)$#$1#;    # Verzeichnisnamen extrahieren
    $path =~ s#/#\\#g;    # Slashes in Backslashes wandeln
    $path =~ s#\\$##;    # Backslash am Ende entfernen
    #
    return $path;
}

# Subroutine zum Extrahieren des Verzeichnisnamens aus einem Pfad (Unix-Schreibweise, d.h. mit Slashes getrennte Verzeichnisse)
sub Path2DirUnix {
    my $path = $_[0];
    #
    $path =~ s#\\#/#g;    # Backslashes in Slashes wandeln
    $path =~ s#^((?:.+/)*)(?:[^/]+)$#$1#;    # Verzeichnisnamen extrahieren
    $path =~ s#/$##;    # Slash am Ende entfernen
    #
    return $path;
}

# Subroutine zum Extrahieren des übergeordneten Verzeichnisnamens aus einem übergebenen Verzeichnis
sub SuperDir {
    my $path = $_[0];
    #
    $path =~ s#\\#/#g;    # Backslashes in Slashes wandeln
    $path =~ s#/$##;    # Slash am Ende entfernen
    $path =~ s#^((?:.+/)*)(?:[^/]+)$#$1#;    # übergeordneten Verzeichnisnamen extrahieren
    $path =~ s#/$##;    # Slash am Ende entfernen
    $path =~ s#/#\\#g;    # Slashes in Backslashes wandeln
    #
    return $path;
}

# Subroutine zum Extrahieren des übergeordneten Verzeichnisnamens aus einem übergebenen Verzeichnis
sub SuperDirUnix {
    my $path = $_[0];
    #
    $path =~ s#\\#/#g;    # Backslashes in Slashes wandeln
    $path =~ s#/$##;    # Slash am Ende entfernen
    $path =~ s#^((?:.+/)*)(?:[^/]+)$#$1#;    # übergeordneten Verzeichnisnamen extrahieren
    $path =~ s#/$##;    # Slash am Ende entfernen
    #
    return $path;
}
