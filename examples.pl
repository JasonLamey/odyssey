#!d:\strawberry\perl\bin\perl.exe

my $superhero = 'Groot';

print $superhero . "\n";

my @superheroes = ( 'Captain America', 'Iron Man', 'Hulk', 'Rainbow Dash' );

foreach my $hero ( @superheroes ) {
	print "$hero\n";
}

my %superheroes = ( 'Hulk' => 'strong', 'Rainbow Dash' => 'colorful', 'Iron Man' => 'smart' );

foreach my $person ( keys %superheroes )
{
	print "$person is $superheroes{$person}.\n";
}


# lines that start with a '#' character are comments, and are ignored by the computer.

# $scalar = single item
# @array  = list of items
# %hash   = key/value pairs
