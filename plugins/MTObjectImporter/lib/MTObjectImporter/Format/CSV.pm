package MTObjectImporter::Format::CSV;
use strict;
use warnings;

use Class::Accessor::Fast 'moose-like';
extends qw/MTObjectImporter::Format/;

use Text::CSV;
use IO::Scalar;
use Path::Class;

sub parse_file {
    my ($self, $csv_path, $sep_char) = @_;
    my $csv_option = {
        binary => 1,
        auto_diag => 1,
    };
    $csv_option->{sep_char} = $sep_char if $sep_char;
    my $csv = Text::CSV->new($csv_option);
    my $csv_fh = file($csv_path)->open('<:utf8');
    $csv->column_names($csv->getline($csv_fh));
    $csv->getline_hr_all($csv_fh);
}

sub parse_string {
    my ($self, $csv_string, $sep_char) = @_;
    my $csv_option = {
        binary => 1,
        auto_diag => 1,
    };
    $csv_option->{sep_char} = $sep_char if $sep_char;
    my $csv = Text::CSV_XS->new($csv_option);
    my $csv_fh = IO::Scalar->new(\$csv_string);
    $csv->column_names($csv->getline($csv_fh));
    $csv->getline_hr_all($csv_fh);
}

1;

__END__

=head1 NAME

MTObjectImporter::Format::CSV - CSV format plugin for MTObjectImporter.

=head1 METHODS

=head2 $mtoi->parse_string($csv_string)

The parse_string method receive csv format string, and return an array reference that includes hash references that can use MT::Object::set_values argument.

=head2 $mtoi->parse_file('/path/to/file/foo.csv')

The parse_file method receive csv format format, and return an array reference that includes hash references that can use MT::Object::set_values argument.
Support encode UTF-8 Only.

=head1 AUTHOR

HIGASHI Taiju <higashi@taiju.info>

=head1 COPYRIGHT

HIGASHI Taiju 2013-

=head1 LICENSE

This software is licensed under the same terms as Perl itself.

=head1 SEE ALSO

L<MTObjectImporter::Format>
