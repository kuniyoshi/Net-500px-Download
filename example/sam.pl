#!/usr/bin/perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use FindBin;
use lib "$FindBin::Bin/../lib";
use Net::500px::Download;

my @uris = grep { $_ }
           map  { chomp; $_ }
           <DATA>;

print map { "Saved as $_\n" }
      map { Net::500px::Download->download( $_ ) }
      @uris;

__DATA__
http://500px.com/photo/948769
http://500px.com/photo/886101

