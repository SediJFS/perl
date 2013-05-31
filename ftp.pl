#!/usr/bin/env perl

# Autor: Josef Florian Sedlmeier
# Datum: 2013/05/31
# FTP-Lister

use strict;
use warnings;

use Log::Log4perl qw( :easy );
# load FTP-module
use Net::FTPSSL;

# Initialisation of Log4perl.
Log::Log4perl->easy_init( $DEBUG );

# Ask for Connection details WARNING! Password is displayed in console!!!
print "Host: ";
my $host = <STDIN>;
chomp($host);
print "Port: ";
my $port = <STDIN>;
chomp($port);
print "Username: ";
my $user = <STDIN>;
chomp($user);
print "Password: ";
my $password = <STDIN>;
chomp($password);

# Open FTP-connection with given details
my $ftps = Net::FTPSSL->new($host,
                        Port => $port,
                        Encryption => 'E',
                        Debug => 1)
    or die "Cannot connect to $host";

$ftps->login("$user", "$password")
    or die "Cannot login ", $ftps->last_message;

# list files located at ftp root and write them into an array
my @files = $ftps->list("/")
    or die "Cannot list directory ", $ftps->last_message;
# DEBUG @files;

# Open and write to Filehandle (output.txt)
open(FH, ">", "output.txt")
    or die "cannot create File: $!";
print FH @files;
close FH;
