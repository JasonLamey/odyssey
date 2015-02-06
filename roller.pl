#!d:/strawberry/perl/bin/perl.exe

$num_dice = 2;
$num_sides = 6;

$roll_count = 1;
@rolls = ();

while ( $roll_count <= $num_dice )
{
  $rolled_number = int( rand( $num_sides ) ) + 1;
  push( @rolls, $rolled_number );
  $roll_count++;
}

print "Here are my rolls: ";
foreach $number ( @rolls )
{
  print "$number, ";
}
