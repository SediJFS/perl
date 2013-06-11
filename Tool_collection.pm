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
/;


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
#####################################################################
#####################################################################
