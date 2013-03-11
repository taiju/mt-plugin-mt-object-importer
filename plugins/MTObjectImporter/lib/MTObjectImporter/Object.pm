package MTObjectImporter::Object;
use strict;
use warnings;

use Class::Accessor::Fast 'moose-like';

has name => ( is => 'ro' );
has primary_key => ( is => 'ro' );
has module => ( is => 'ro' );
has sleep => ( is => 'rw' );

sub imports {
    my ($self, $objects, $sleep) = @_;
    $self->sleep( $sleep ? $sleep : 0 );
    $self->_import($_) for @$objects;
}

sub _import {
    my ($self, $obj) = @_;
    my $mt_object = $self->get_instance($obj->{$self->primary_key});
    $mt_object->set_values($obj);
    $mt_object->save or die "Saving failed: ", $mt_object->errstr;
    $self->log($mt_object);
    sleep $self->sleep if $self->sleep;
}

sub get_instance {
    my ($self, $pkey) = @_;
    $pkey ? $self->module->get_by_key({ $self->primary_key => $pkey }) :
            $self->module->new;
}

sub log {
    my ($self, $mt_object) = @_;
    print "success import\n";
    printf "    %s: %s\n", $self->name, $mt_object->{column_values}->{$self->primary_key}
}

1;

__END__

=head1 NAME

MTObjectImporter::Object - Object plugins base of MTObjectImporter.

=head1 METHODS

=head2 $mtoio->name

Return this object lc name.

=head2 $mtoio->primary_key

Return this object's primary_key

=head2 $mtoio->module

Return this object's module name.

=head2 $mtoio->sleep

Set number of seconds to sleep between objects import.

=head2 $mtoio->imports($mt_objects)

This is abstract function.
See also MTObjectImporter::Object::Foo::imports

=head2 $mtoio->get_instance($primary_key)

Return this object instance.

=head2 $mtoio->log($object)

Output object import log.

=head1 AUTHOR

HIGASHI Taiju <higashi@taiju.info>

=head1 COPYRIGHT

HIGASHI Taiju 2013-

=head1 LICENSE

This software is licensed under the same terms as Perl itself.

=head1 SEE ALSO

L<MT::Object>, L<MTObjectImporter::Object::Entry>, L<MTObjectImporter::Object::Page>
