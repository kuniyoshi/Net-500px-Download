use inc::Module::Install;
name 'Net-500px-Download';
all_from 'lib/Net/500px/Download.pm';

requires 'Path::Class';
requires 'Net::500px::Download';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;

