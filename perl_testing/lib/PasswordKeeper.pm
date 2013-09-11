package PasswordKeeper;

sub new
{
    my ( $class, $username ) = @_;
    my $password             = $class->encrypt( $username );
    bless
    {
        user     => $username,
        tries    => 0,
        password => $password,
    }, $class;
}

sub verify
{
    my ( $self, $guess ) = @_;
    
    return 1 if $self->encrypt( $guess ) eq $self->{password};
    
    $self->{tries}++;
    exit if $self->{tries} == 3;
    
    return 0;
}

sub encrypt
{
    my ( $class, $password ) = @_;
    return scalar reverse $password;
}

1;
