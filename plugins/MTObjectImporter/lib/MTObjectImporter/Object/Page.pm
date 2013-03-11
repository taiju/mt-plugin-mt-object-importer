package MTObjectImporter::Object::Page;
use strict;
use warnings;

use Class::Accessor::Fast 'moose-like';
extends qw/MTObjectImporter::Object/;

sub new {
    my ($class, $arg) = @_;
    $arg->{name} = 'page';
    $arg->{primary_key} = 'id';
    $arg->{module} = 'MT::Page';
    $class->SUPER::new($arg);
}

1;

__END__

=head1 NAME

MTObjectImporter::Object::Page - MT::Page object plugin for MTObjectImporter.

=head1 METHODS

=head2 $mtoi->name

Return 'page'.

=head2 $mtoi->primary_key

Return 'id'.

=head2 $mtoi->module

Return 'MT::Page'.

=head2 $mtoi->imports($mt_pages)

The imports methods receive an array reference that includes hash references that can use MT::Object::set_values argument, and save it to database pass through MT::Page->save.

=head2 $mtoio->get_instance($primary_key)

Return this MT::Page object instance.

=head1 AUTHOR

HIGASHI Taiju <higashi@taiju.info>

=head1 COPYRIGHT

HIGASHI Taiju 2013-

=head1 LICENSE

This software is licensed under the same terms as Perl itself.

=head1 SEE ALSO

L<MT::Object>, L<MTObjectImporter::Object>
