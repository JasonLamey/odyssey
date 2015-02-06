#!d:/strawberry/bin/perl.exe

my %hash = (
              'one' => 1,
              'two' => 2,
              'three' => 3,
              'four' => 4,
           );

foreach my $key ( sort keys %hash )
{
  print "$key = $hash{$key}\n";
}
