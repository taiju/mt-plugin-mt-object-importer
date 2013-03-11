use strict;
use warnings;

use Test::More;
use lib 'lib', 'extlib', 't/lib', 'plugins/MTObjectImporter/lib';
use MT::Test qw/:db/;

BEGIN {
    use_ok('MTObjectImporter');
    use_ok('MTObjectImporter::Format');
    use_ok('MTObjectImporter::Format::YAML');
    use_ok('MTObjectImporter::Format::JSON');
    use_ok('MTObjectImporter::Format::CSV');
    use_ok('MTObjectImporter::Format::TSV');
    use_ok('MTObjectImporter::Object');
    use_ok('MTObjectImporter::Object::Entry');
    use_ok('MTObjectImporter::Object::Page');
    use_ok('MTObjectImporter::Object::Author');
}

subtest "plugin" => sub {
    my $mtoi = MTObjectImporter->new({
        format => 'yaml',
        object => 'entry',
    });
    is_deeply($mtoi->formats, {
        yaml => 'MTObjectImporter::Format::YAML',
        json => 'MTObjectImporter::Format::JSON',
        csv => 'MTObjectImporter::Format::CSV',
        tsv => 'MTObjectImporter::Format::TSV',
    }, 'load formats ok');
    is_deeply($mtoi->objects, {
        entry => 'MTObjectImporter::Object::Entry',
        page => 'MTObjectImporter::Object::Page',
        author => 'MTObjectImporter::Object::Author',
    }, 'load formats ok');
    is_deeply($mtoi->plugins, {
        formats => {
            yaml => 'MTObjectImporter::Format::YAML',
            json => 'MTObjectImporter::Format::JSON',
            csv => 'MTObjectImporter::Format::CSV',
            tsv => 'MTObjectImporter::Format::TSV',
        },
        objects => {
            entry => 'MTObjectImporter::Object::Entry',
            page => 'MTObjectImporter::Object::Page',
            author => 'MTObjectImporter::Object::Author',
        },
    }, 'load plugins ok');
};

subtest "format-yaml" => sub {
    my $mtoi_yaml = MTObjectImporter->new({
        format => 'yaml',
        object => 'entry',
    });
    isa_ok($mtoi_yaml->format, 'MTObjectImporter::Format::YAML');
    my $yaml = <<YAML;
id: 1
blog_id: 1
title: Title of updated by yaml
text: Body of updated by yaml
author_id: 2
status: 1
YAML
    is_deeply([{
        id => 1,
        blog_id => 1,
        title => 'Title of updated by yaml',
        text => 'Body of updated by yaml',
        author_id => 2,
        status => 1,
    }], $mtoi_yaml->parse_string($yaml), 'YAML string ok');
    is_deeply([{
        id => 1,
        blog_id => 1,
        title => 'Title of updated by yaml',
        text => 'Body of updated by yaml',
        author_id => 2,
        status => 1,
    }, {
        blog_id => 1,
        title => 'Title of added by yaml',
        text => 'Body of added by yaml',
        author_id => 2,
        status => 1,
    }], $mtoi_yaml->parse_file('plugins/MTObjectImporter/t/entries.yaml'), 'YAML file ok');
};

subtest "format-json" => sub {
    my $mtoi_json = MTObjectImporter->new({
        format => 'json',
        object => 'entry',
    });
    isa_ok($mtoi_json->format, 'MTObjectImporter::Format::JSON');
    my $json = <<JSON;
{
    "id": 1,
    "blog_id": 1,
    "title": "Title of updated by json",
    "text": "Body of updated by json",
    "author_id": 2,
    "status": 1
}
JSON
    is_deeply([{
        id => 1,
        blog_id => 1,
        title => 'Title of updated by json',
        text => 'Body of updated by json',
        author_id => 2,
        status => 1,
    }], $mtoi_json->parse_string($json), 'JSON string ok');
    is_deeply([{
        id => 1,
        blog_id => 1,
        title => 'Title of updated by json',
        text => 'Body of updated by json',
        author_id => 2,
        status => 1,
    }, {
        blog_id => 1,
        title => 'Title of added by json',
        text => 'Body of added by json',
        author_id => 2,
        status => 1,
    }], $mtoi_json->parse_file('plugins/MTObjectImporter/t/entries.json'), 'JSON file ok'); 
};

subtest "format-csv" => sub {
    my $mtoi_csv = MTObjectImporter->new({
        format => 'csv',
        object => 'entry',
    });
    isa_ok($mtoi_csv->format, 'MTObjectImporter::Format::CSV');
    my $csv = <<CSV;
id,blog_id,title,text,author_id,status
1,1,Title of updated by csv,Body of updated by csv,2,1
CSV
    is_deeply([{
        id => 1,
        blog_id => 1,
        title => 'Title of updated by csv',
        text => 'Body of updated by csv',
        author_id => 2,
        status => 1,
    }], $mtoi_csv->parse_string($csv), 'CSV string ok');
    is_deeply([{
        id => 1,
        blog_id => 1,
        title => 'Title of updated by csv',
        text => 'Body of updated by csv',
        author_id => 2,
        status => 1,
    }, {
        id => '',
        blog_id => 1,
        title => 'Title of added by csv',
        text => 'Body of added by csv',
        author_id => 2,
        status => 1,
    }], $mtoi_csv->parse_file('plugins/MTObjectImporter/t/entries.csv'), 'CSV file ok'); 
};

subtest "format-tsv" => sub {
    my $mtoi_tsv = MTObjectImporter->new({
        format => 'tsv',
        object => 'entry',
    });
    isa_ok($mtoi_tsv->format, 'MTObjectImporter::Format::TSV');
    my $tsv = <<TSV;
id\tblog_id\ttitle\ttext\tauthor_id\tstatus
1\t1\tTitle of updated by tsv\tBody of updated by tsv\t2\t1
TSV
    is_deeply([{
        id => 1,
        blog_id => 1,
        title => 'Title of updated by tsv',
        text => 'Body of updated by tsv',
        author_id => 2,
        status => 1,
    }], $mtoi_tsv->parse_string($tsv), 'TSV string ok');
    is_deeply([{
        id => 1,
        blog_id => 1,
        title => 'Title of updated by tsv',
        text => 'Body of updated by tsv',
        author_id => 2,
        status => 1,
    }, {
        id => '',
        blog_id => 1,
        title => 'Title of added by tsv',
        text => 'Body of added by tsv',
        author_id => 2,
        status => 1,
    }], $mtoi_tsv->parse_file('plugins/MTObjectImporter/t/entries.tsv'), 'TSV file ok'); 
};

subtest "object-entry" => sub {
    diag('Please wait a moment. Init test db now.'); 
    MT::Test->init_data;
    diag('Init data done.'); 
    my $mtoi_entry = MTObjectImporter->new({
        format => 'yaml',
        object => 'entry',
    });
    my $entries = $mtoi_entry->parse_file('plugins/MTObjectImporter/t/entries.yaml');
    $mtoi_entry->imports($entries);
    my $updated_entry = MT::Entry->load(1);
    my $added_entry = MT::Entry->load(undef, {
        sort => 'id',
        direction => 'descend',
        limit => 1,
    });
    is($updated_entry->title, 'Title of updated by yaml', 'update entry title');
    is($updated_entry->text, 'Body of updated by yaml', 'update entry body');
    is($added_entry->title, 'Title of added by yaml', 'added entry title');
    is($added_entry->text, 'Body of added by yaml', 'added entry body');
};

subtest "object-page" => sub {
    diag('Please wait a moment. Init test db now.'); 
    MT::Test->init_data;
    diag('Init data done.'); 
    my $mtoi_page = MTObjectImporter->new({
        format => 'yaml',
        object => 'page',
    });
    my $pages = $mtoi_page->parse_file('plugins/MTObjectImporter/t/entries.yaml');
    $mtoi_page->imports($pages);
    my $updated_page = MT::Page->load(1);
    my $added_page = MT::Page->load(undef, {
        sort => 'id',
        direction => 'descend',
        limit => 1,
    });
    is($updated_page->title, 'Title of updated by yaml', 'update page title');
    is($updated_page->text, 'Body of updated by yaml', 'update page body');
    is($added_page->title, 'Title of added by yaml', 'added page title');
    is($added_page->text, 'Body of added by yaml', 'added page body');
};

subtest "object-author" => sub {
    diag('Please wait a moment. Init test db now.'); 
    MT::Test->init_data;
    diag('Init data done.'); 
    my $mtoi_author = MTObjectImporter->new({
        format => 'yaml',
        object => 'author',
    });
    my $authors = $mtoi_author->parse_file('plugins/MTObjectImporter/t/authors.yaml');
    $mtoi_author->imports($authors);
    my $updated_author = MT::Author->load(2);
    my $added_author = MT::Author->load(undef, {
        sort => 'id',
        direction => 'descend',
        limit => 1,
    });
    is($updated_author->name, 'taiju', 'update author name');
    is($updated_author->email, 'higashi@taiju.info', 'update author email');
    is($updated_author->is_valid_password('password'), 1, 'update author password');
    is($added_author->name, 'ujiat', 'added author name');
    is($added_author->email, 'higashi+rev@taiju.info', 'added author email');
    is($added_author->is_valid_password('drowssap'), 1, 'added author password');
};

done_testing;
