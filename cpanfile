# Module requirements
requires 'Hash::Union';
requires 'JSON';
requires 'PerlIO::gzip';

# From ensembl-test

requires 'IO::Scalar';
requires 'IO::Stringy';
requires 'Archive::Zip';
requires 'BSD::Resource';
requires 'File::Sync';
requires 'Test::Fake::HTTPD';
requires 'Test::TCP';
requires 'Net::FTP::Mock';

#Test requirements
test_requires 'Test::More';
test_requires 'Test::Differences';
test_requires 'Test::Deep';
test_requires 'Test::Exception';
