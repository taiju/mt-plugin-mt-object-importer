package MTObjectImporter::Format::TSV;
use strict;
use warnings;

use Class::Accessor::Fast 'moose-like';
extends qw/MTObjectImporter::Format::CSV/;

sub parse_file {
    my ($self, $tsv_path) = @_;
    $self->SUPER::parse_file($tsv_path, "\t");
}

sub parse_string {
    my ($self, $tsv_string) = @_;
    $self->SUPER::parse_string($tsv_string, "\t");
}

1;

__END__

=head1 NAME

MTObjectImporter::Format::TSV - TSV format plugin for MTObjectImporter.

=head1 METHODS

=head2 $mtoi->parse_string($tsv_string)

The parse_string method receive tsv format string, and return an array reference that includes hash references that can use MT::Object::set_values argument.

=head2 $mtoi->parse_file('/path/to/file/foo.tsv')

The parse_file method receive tsv format format, and return an array reference that includes hash references that can use MT::Object::set_values argument.
Support encode UTF-8 Only.

=head1 AUTHOR

HIGASHI Taiju <higashi@taiju.info>

=head1 COPYRIGHT

HIGASHI Taiju 2013-

=head1 LICENSE

This software is licensed under the same terms as Perl itself.

=head1 SEE ALSO

L<MTObjectImporter::Format>
