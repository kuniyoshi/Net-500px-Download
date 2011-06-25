package Net::500px::Download;
use strict;
use warnings;
use Path::Class qw( file );
use Mojo::UserAgent;

my $ua = Mojo::UserAgent->new;
$ua->name( "Net::500px::Download/1.0" );

our $PATH    = "images";
our $VERSION = '0.01';

sub download {
    my $uri = do {
        my $candidate = shift;
        $candidate eq __PACKAGE__ ? shift : $candidate;
    };
    my( $title, $src );

    my $res = $ua->get( $uri )->res;

    $res->dom( "h1.title" )->each( sub {
        my $h1 = shift;
        $title = $h1->text;
    } );
    $res->dom( "#mainphoto" )->each( sub {
        my $img = shift;
        $src = $img->{src};
    } );

    die "Could not get image path."
        unless $src;

    $title //= "untitled-image";
    $title .= ".jpg";

    my $file = file( $PATH, $title );
    $file->dir->mkpath;

    print { $file->open( ">:raw" ) } $ua->get( $src )->res->body;

    return $file;
}

1;
__END__

=head1 NAME

Net::500px::Download - save your favorite it

=head1 SYNOPSIS

  use Net::500px::Download;
  my $file = Net::500px::Download->( "http://500px.com/photo/948769" );
  say "Saved as $file";

=head1 DESCRIPTION

Net::500px::Download is a very simple downloader of the 500px.

=head1 AUTHOR

kuniyoshi kouji E<lt>kuniyoshi@cpan.orgE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

