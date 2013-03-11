package MTObjectImporter::Object::Author;
use strict;
use warnings;
use Carp;

use Class::Accessor::Fast 'moose-like';
extends qw/MTObjectImporter::Object/;

sub new {
    my ($class, $arg) = @_;
    $arg->{name} = 'author';
    $arg->{primary_key} = 'id';
    $arg->{module} = 'MT::Author';
    $class->SUPER::new($arg);
}

sub _import {
    my ($self, $obj) = @_;
    MT::Author->add_trigger('pre_save' => sub {
        my ($author, $orig_author) = @_;
        $author->set_password($obj->{password}) if $obj->{password};
    });
    $self->SUPER::_import($obj);
}

1;

__END__

=head1 NAME

MTObjectImporter::Object::Author - MT::Author object plugin for MTObjectImporter.

=head1 METHODS

=head2 $mtoi->name

Return 'author'.

=head2 $mtoi->primary_key

Return 'id'.

=head2 $mtoi->module

Return 'MT::Author'.

=head2 $mtoi->imports($mt_authors)

The imports methods receive an array reference that includes hash references that can use MT::Object::set_values argument, and save it to database pass through MT::Author->save.

=head2 $mtoio->get_instance($primary_key)

Return this MT::Author object instance.

=head1 AUTHOR

HIGASHI Taiju <higashi@taiju.info>

=head1 COPYRIGHT

HIGASHI Taiju 2013-

=head1 LICENSE

This software is licensed under the same terms as Perl itself.

=head1 SEE ALSO

L<MT::Object>, L<MTObjectImporter::Object>
