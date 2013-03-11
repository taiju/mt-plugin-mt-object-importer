package MTObjectImporter::Object::Entry;
use strict;
use warnings;

use Class::Accessor::Fast 'moose-like';
extends qw/MTObjectImporter::Object/;

sub new {
    my ($class, $arg) = @_;
    $arg->{name} = 'entry';
    $arg->{primary_key} = 'id';
    $arg->{module} = 'MT::Entry';
    $class->SUPER::new($arg);
}

1;

__END__

=head1 NAME

MTObjectImporter::Object::Entry - MT::Entry object plugin for MTObjectImporter.

=head1 METHODS

=head2 $mtoi->name

Return 'entry'.

=head2 $mtoi->primary_key

Return 'id'.

=head2 $mtoi->module

Return 'MT::Entry'.

=head2 $mtoi->imports($mt_entries)

The imports methods receive an array reference that includes hash references that can use MT::Object::set_values argument, and save it to database pass through MT::Entry->save.

=head2 $mtoio->get_instance($primary_key)

Return this MT::Entry object instance.

=head1 AUTHOR

HIGASHI Taiju <higashi@taiju.info>

=head1 COPYRIGHT

HIGASHI Taiju 2013-

=head1 LICENSE

This software is licensed under the same terms as Perl itself.

=head1 SEE ALSO

L<MT::Object>, L<MTObjectImporter::Object>
