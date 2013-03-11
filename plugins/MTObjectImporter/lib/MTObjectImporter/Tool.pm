package MTObjectImporter::Tool;
use strict;
use warnings;

use MTObjectImporter;
use Carp;
use base qw/MT::Tool MTObjectImporter/;

my $option = {
    format => '',
    object => '',
    file   => '',
    sleep  => 0,
    usage => 0,
};

sub help {
    q {
        tools/mt-object-importer
          require:
            --file <path>        path to import file
            --format <format>    format of import file
                                   - yaml
                                   - json
                                   - csv
                                   - tsv
                                   - or others...
            --object <object>    kind of mt object
                                   - entry
                                   - page
                                   - author
                                   - or others...

          optional:
            --sleep <sec>        number of second while import next object
            --usage              print usage for mt-object-importer
            --help               it's me!
    };
}

sub usage {
    q {--format=<format> --object=<object> --file=<path> [--sleep=<sec>]};
}

sub options {
    'format=s' => \$option->{format},
    'object=s' => \$option->{object},
    'file=s'   => \$option->{file},
    'sleep=i'  => \$option->{sleep},
    'usage'    => \$option->{usage},
}

sub main {
    my $class = shift;
    my ($verbose) = $class->SUPER::main(@_);
    if ($option->{usage} || !$option->{file} || !$option->{format} || !$option->{object}) {
        $class->show_usage;
        exit;
    }
    my $mtoi = MTObjectImporter->new({
        format => $option->{format},
        object => $option->{object},
    });
    my $objects = $mtoi->parse_file($option->{file});
    $mtoi->imports($objects, $option->{sleep});
}

1;
