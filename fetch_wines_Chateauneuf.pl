=pod
=head1 Description

  Fetch wines with significant % of cinsault in Chateauneuf AOC 

=head1 Author

 E. Cabrol

=head1 Last update

 September 2014

=cut


use strict;
use LWP::Simple;
my $path = 'http://www.chateauneuf.dk/en/';
my $cepage = 'Cinsault';
my $content = get('http://www.chateauneuf.dk/en/index.htm');
my %domaine = ($content =~ m/(cdpen\d+\.htm)">(.+?)<\/a>/g);

foreach my $page (keys %domaine) {
	my $cdp = get($path.$page);
	while ($cdp =~ /(Chateauneuf.+(\n){1}.+?(\d+)\%\s+$cepage)/g) {
		my $quest = $1;			
		my $percent = $3;
		$quest =~ s/<.+?>//g;		# remove tags
		$quest =~ s/\n//g;		# remove newline
		if ($percent >=10) {print $domaine{$page},"\t",$quest,"\n\n";}
	}
}