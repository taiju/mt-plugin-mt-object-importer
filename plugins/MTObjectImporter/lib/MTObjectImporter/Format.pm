package MTObjectImporter::Format;
use strict;
use warnings;

use Class::Accessor::Fast 'moose-like';

sub parse_file {}
sub parse_string {}

1;

__END__

=head1 NAME

MTObjectImporter::Format - Format plugins base of MTObjectImporter.

=head1 METHODS

=head2 $mtoif->parse_string('foo-format-string')

This is abstract function.
See also MTObjectImporter::Format::Foo::parse_string

=head2 $mtoif->parse_file('/path/to/file/foo.format')

This is abstract function.
See also MTObjectImporter::Format::Foo::parse_file

=head1 HOW TO ADD PLUGIN

You can add format plugin of MTObjectImporter.

Place the your plugin file in /path/to/mt/plugins/MTObjectImporter/lib/MTObjectImporter/Format such as Foo.pm.

Foo.pm must inherit MTObjectImporter::Format, and imprements parse_string method and parse_file method.

The parse_string method must receive a argument that foo format string such as YAML, JSON or CSV format string, and return an array reference that includes hash references that can use MT::Object::set_values argument.

The parse_file method must receive a argument that foo format file path such as YAML, JSON or CSV format file, and return an array reference that includes hash references that can use MT::Object::set_values argument.

=head1 AUTHOR

HIGASHI Taiju <higashi@taiju.info>

=head1 COPYRIGHT

HIGASHI Taiju 2013-

=head1 LICENSE

This software is licensed under the same terms as Perl itself.
