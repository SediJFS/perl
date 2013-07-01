#!/usr/bin/env perl

#Basisklasse 'BankAccount' erstellen
package BankAccount;
use Carp;
use Moose;
# Attribute der Klasse festlegen
has 'balance' => ( isa => 'Int', is => 'rw', default => 0 );
# Klassenmethoden festlegen
sub deposit {
    my ( $self, $amount ) = @_;
    $self->balance( $self->balance + $amount );
}

sub withdraw {
    my ( $self, $amount ) = @_;
    my $current_balance = $self->balance();
    ( $current_balance >= $amount )
        || print "Account overdrawn ";
    $self->balance( $current_balance - $amount );
}

sub current_balance {
    my $self = shift;
    $self->balance;
}

package CheckingAccount;
use Moose;
# Basisklasse erweitern
extends 'BankAccount';
# zusätzliche Attribute festlegen
has 'overdraft_account' => ( isa => 'BankAccount', is => 'rw' );
# der 'before'-modifier wird VOR der eigentlichen Subroutine ausgeführt. Er wird
# also praktisch am Anfang der Subroutine eingefügt.
# Der folgende Codeblock überprüft, ob das Konto eine genügende Deckung hat, um
# eine Abbuchung vorzunehmen.
before 'withdraw' => sub {
    my ( $self, $amount ) = @_;
    my $overdraft_amount = $amount - $self->balance();
    if ( $self->overdraft_account && $overdraft_amount > 0 ) {
        $self->overdraft_account->withdraw( $overdraft_amount );
        $self->deposit( $overdraft_amount );
    }
};

# Objekte anlegen und was damit machen.
my $konto = BankAccount->new();
print $konto->current_balance, "\n";
$konto->deposit(5000);
print $konto->current_balance, "\n";
$konto->withdraw(3000);
print $konto->current_balance, "\n";
$konto->withdraw(2500);
print $konto->current_balance, "\n";
$konto->deposit(500);
print $konto->current_balance, "\n";
