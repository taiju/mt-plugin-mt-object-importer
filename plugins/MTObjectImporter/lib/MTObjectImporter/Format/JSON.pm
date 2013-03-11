package MTObjectImporter::Format::JSON;
use strict;
use warnings;

use Class::Accessor::Fast 'moose-like';
extends qw/MTObjectImporter::Format/;

use JSON::Syck qw(Load LoadFile);
use Path::Class;
use Encode;

sub parse_file {
    my ($self, $json_path) = @_;
    my $json_dump = LoadFile($json_path);
    (ref $json_dump eq 'HASH') ? [$json_dump] : $json_dump;
}

sub parse_string {
    my ($self, $json_string) = @_;
    my $json_dump = Load($json_string);
    (ref $json_dump eq 'HASH') ? [$json_dump] : $json_dump;
}

1;

__END__

=head1 NAME

MTObjectImporter::Format::JSON - JSON format plugin for MTObjectImporter.

=head1 METHODS

=head2 $mtoi->parse_string($json_string)

The parse_string method receive json format string, and return an array reference that includes hash references that can use MT::Object::set_values argument.

=head2 $mtoi->parse_file('/path/to/file/foo.json')

The parse_file method receive json format format, and return an array reference that includes hash references that can use MT::Object::set_values argument.

=head1 AUTHOR

HIGASHI Taiju <higashi@taiju.info>

=head1 COPYRIGHT

HIGASHI Taiju 2013-

=head1 LICENSE

This software is licensed under the same terms as Perl itself.

=head1 SEE ALSO

L<MTObjectImporter::Format>
