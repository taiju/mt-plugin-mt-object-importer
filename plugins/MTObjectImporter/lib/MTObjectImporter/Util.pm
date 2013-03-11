package MTObjectImporter::Util;
use strict;
use warnings;

use base 'Exporter';
our @EXPORT_OK = qw/titlecase/;

sub titlecase {
    my $string = shift;
    my @chars = split //, $string;
    my ($first, @rest) = @chars;
    join '', (uc $first, map { lc $_ } @rest);
}

1;

__END__

=head1 NAME

MTObjectImporter::Util - Export utility functions for MTObjectImporter.

=head1 METHODS

=head2 titlecase('title')

Convert title case string such as 'title' to 'Title'.

=head1 AUTHOR

HIGASHI Taiju <higashi@taiju.info>

=head1 COPYRIGHT

HIGASHI Taiju 2013-

=head1 LICENSE

This software is licensed under the same terms as Perl itself.
