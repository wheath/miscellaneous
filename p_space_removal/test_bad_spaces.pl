use HTML::Entities;
use WWW::Mechanize;
use WWW::Mechanize::TreeBuilder;
use strict;

#web screenscrape all urls listed in hopone_urls.csv and get all paragraphs
#to see if they have a nbsp.
    
my $m = WWW::Mechanize->new();
WWW::Mechanize::TreeBuilder->meta->apply($m);

open FILE, 'hopone_urls.csv' or die $!;
my @urls = <FILE>;

foreach(@urls) {
  my $url = $_;
  print "\n\nurl: $url\n\n";
  $m->get($url);
  # Find all <p> tags
  my @list = $m->find('p');

  foreach(@list) {
    my $c = $_->as_text();
    my $encoded = encode_entities($c);
    if ($encoded =~ /\&nbsp;/) {
      print "\n\n_dbg &nbsp matched";
      print "\n\n$encoded\n\n";
    }
  }
}
