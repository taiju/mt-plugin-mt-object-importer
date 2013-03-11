package MTObjectImporter::Format::YAML;
use strict;
use warnings;

use Class::Accessor::Fast 'moose-like';
extends qw/MTObjectImporter::Format/;

use YAML::Syck qw(Load LoadFile);

sub parse_file {
    my ($self, $yaml_path) = @_;
    my $yaml_dump = LoadFile($yaml_path);
    (ref $yaml_dump eq 'HASH') ? [$yaml_dump] : $yaml_dump;
}

sub parse_string {
    my ($self, $yaml_string) = @_;
    my $yaml_dump = Load($yaml_string);
    (ref $yaml_dump eq 'HASH') ? [$yaml_dump] : $yaml_dump;
}

1;

__END__

=head1 NAME

MTObjectImporter::Format::YAML - YAML format plugin for MTObjectImporter.

=head1 METHODS

=head2 $mtoi->parse_string($yaml_string)

The parse_string method receive yaml format string, and return an array reference that includes hash references that can use MT::Object::set_values argument.

=head2 $mtoi->parse_file('/path/to/file/foo.yaml')

The parse_file method receive yaml format format, and return an array reference that includes hash references that can use MT::Object::set_values argument.

=head1 AUTHOR

HIGASHI Taiju <higashi@taiju.info>

=head1 COPYRIGHT

HIGASHI Taiju 2013-

=head1 LICENSE

This software is licensed under the same terms as Perl itself.

=head1 SEE ALSO

L<MTObjectImporter::Format>
