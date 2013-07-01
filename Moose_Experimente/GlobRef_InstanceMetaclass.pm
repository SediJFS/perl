#!/usr/bin/env perl

package My::Meta::Instance;

  use Scalar::Util qw( weaken );
  use Symbol qw( gensym );

  use Moose;
  extends 'Moose::Meta::Instance';

  sub create_instance {
      my $self = shift;
      my $sym = gensym();
      bless $sym, $self->_class_name;
  }

  sub clone_instance {
      my ( $self, $instance ) = @_;

      my $new_sym = gensym();
      %{*$new_sym} = %{*$instance};

      bless $new_sym, $self->_class_name;
  }

  sub get_slot_value {
      my ( $self, $instance, $slot_name ) = @_;
      return *$instance->{$slot_name};
  }

  sub set_slot_value {
      my ( $self, $instance, $slot_name, $value ) = @_;
      *$instance->{$slot_name} = $value;
  }

  sub deinitialize_slot {
      my ( $self, $instance, $slot_name ) = @_;
      delete *$instance->{$slot_name};
  }

  sub is_slot_initialized {
      my ( $self, $instance, $slot_name ) = @_;
      exists *$instance->{$slot_name};
  }

  sub weaken_slot_value {
      my ( $self, $instance, $slot_name ) = @_;
      weaken *$instance->{$slot_name};
  }

  sub inline_create_instance {
      my ( $self, $class_variable ) = @_;
      return 'do { my $sym = Symbol::gensym(); bless $sym, ' . $class_variable . ' }';
  }

  sub inline_slot_access {
      my ( $self, $instance, $slot_name ) = @_;
      return '*{' . $instance . '}->{' . $slot_name . '}';
  }

package MyApp::User;

use metaclass 'Moose::Meta::Class' =>
    ( instance_metaclass => 'My::Meta::Intance' );

use Moose;

has 'name' => (
    is      => 'rw',
    isa     => 'Str',
);

has 'email' => (
    is      => 'rw',
    isa     => 'Str',
);
