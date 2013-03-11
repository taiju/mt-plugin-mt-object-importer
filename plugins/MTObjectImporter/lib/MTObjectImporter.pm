package MTObjectImporter;
use strict;
use warnings;

use Class::Accessor::Fast 'moose-like';
use Carp;
use File::Spec;
use File::Basename;
use Path::Class;
use MTObjectImporter::Object;
use MTObjectImporter::Format;
use MTObjectImporter::Util qw/titlecase/;

our $VERSION = '0.1';

has format  => ( is => 'ro' );
has object  => ( is => 'ro' );
has formats => ( is => 'ro' );
has objects => ( is => 'ro' );
has plugins => ( is => 'ro' );

sub new {
    my ($class, $arg) = @_;
    my $self = {};
    $self->{formats} = __load_formats();
    $self->{objects} = __load_objects();
    croak "require argument that include format and object hash-ref" unless $arg;
    croak "must include format hash-ref" unless $arg->{format};
    croak "must include object hash-ref" unless $arg->{object};
    croak "$arg->{format} is unknown format" unless $self->{formats}->{$arg->{format}};
    croak "$arg->{object} is unknown object" unless $self->{objects}->{$arg->{object}};
    $self->{plugins} = {
        formats => $self->{formats},
        objects => $self->{objects},
    };
    my $format_module = $self->{formats}->{$arg->{format}}; 
    my $object_module = $self->{objects}->{$arg->{object}}; 
    eval "use $format_module";
    $self->{format} = $format_module->new;
    eval "use $object_module";
    $self->{object} = $object_module->new;
    bless $self, $class;
}

sub __load_plugins {
    my $plugin = titlecase(shift);
    sub {
        +{ map {
            my $name = file($_)->basename;
            $name =~ s/\.pm$//;
            lc $name => sprintf('%s::%s::%s', __PACKAGE__, $plugin, $name);
           } dir(dirname(__FILE__), __PACKAGE__, $plugin)->children };
    };
}

*__load_formats = __load_plugins('format');
*__load_objects = __load_plugins('object');

sub parse_file {
    my ($self, $path) = @_;
    $self->format->parse_file($path);
}

sub parse_string {
    my ($self, $path) = @_;
    $self->format->parse_string($path);
}

sub imports {
    my ($self, $objects, $sleep) = @_;
    $self->object->imports($objects, $sleep);
}

sub can_use {
    my ($self, $plugin, $what) = @_;
    my $can_use_plugin = sub {
        my ($plugin, $what) = @_;
        sub {
            my $what = shift;
            defined($self->{$plugin.'s'}->{$what}) ? 1 : 0;
        };
    };
    croak 'require plugin name.' unless $plugin;
    $what ? $can_use_plugin->($plugin)->($what) : $can_use_plugin->($plugin);
}

sub can_use_format {
    shift->can_use('format');
}

sub can_use_object {
    shift->can_use('object');
}

1;

__END__

=head1 NAME

MTObjectImporter - Import MT Object by any format.

=head1 SYNOPSIS

    use MTObjectImporter;
    my $mtoi = MTObjectImporter->new({
        format => 'yaml',
        object => 'entry',
    });
    my $entries = $mtoi->parse_file('/path/to/entries.yaml');
    $mtoi->imports($encoded) or die $!;

=head1 DESCRIPTION

TODO

=head1 METHODS

=head2 $mtoi->format

Return MTObjectImporter instance's format.

=head2 $mtoi->object

Return MTObjectImporter instance's object.

=head2 $mtoi->formats

Return HashRef that MTObjectImporter are supported formats.

=head2 $mtoi->objects

Return HashRef that MTObjectImporter are supported objects.

=head2 $mtoi->plugins

Return HashRef that MTObjectImporter are supported plugins like objects or formats. 

=head2 $mtoi->parse_string

Return HashRef wrapped a ArrayRef from MTObjectImporter Instance's format string.

=head2 $mtoi->parse_file

Return HashRef wrapped a ArrayRef from MTObjectImporter Instance's format file.

=head2 $mtoi->imports($mt_objects, $sleep)

Save data that MTObjectImporter instance's object to database.

$mt_objects is HashRef wrapped a ArrayRef and include columns of MTObjectImporter instance's object.

$mt_objects must use as a MT::Object::set_values argument.

=head2 $mtoi->can_use(format|object => 'foo')

Return 1 or 0 whether can use format or object or others foo.

=head2 $mtoi->can_use_format('foo')

Return 1 or 0 whether can use format foo.

=head2 $mtoi->can_use_object('foo')

Return 1 or 0 whether can use object foo.

=head1 AUTHOR

HIGASHI Taiju <higashi@taiju.info>

=head1 COPYRIGHT

HIGASHI Taiju 2013-

=head1 LICENSE

This software is licensed under the same terms as Perl itself.

=head1 SEE ALSO

L<MT::Object>
