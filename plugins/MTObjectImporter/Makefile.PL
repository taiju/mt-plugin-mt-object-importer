use inc::Module::Install;
name 'MTObjectImporter';
version_from 'lib/MTObjectImporter.pm';
license_from 'lib/MTObjectImporter.pm';

requires 'YAML::Syck';
requires 'JSON::Syck';
requires 'Text::CSV';
requires 'Path::Class';

test_requires 'Test::More' => '2.00';

WriteAll;
