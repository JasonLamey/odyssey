#!d:/strawberry/perl/bin/perl.exe

print "Ready to roll some dice?\n";

while ( 1 == 1 )
{
  print "How many dice should I roll? ";
  $num_dice = <STDIN>;
  chomp $num_dice;

  if ( lc($num_dice) eq 'exit' )
  {
    exit;
  }

  if ( $num_dice < 1 )
  {
    print "Can't roll zero dice, duh!  Try again.\n";
    next;
  }

  print "How many sides should each die have? ";
  $num_sides = <STDIN>;
  chomp $num_sides;

  if ( $num_sides < 1 )
  {
    print "Dice cannot have less than one side, duh!  Try again.\n";
    next;
  }

  print "I will roll $num_dice dice with $num_sides sides each.\n";

  my $total = 0;
  my @rolls = ();
  my $roll_count = 1;
  while ( $roll_count <= $num_dice )
  {
    my $rolled = int( rand($num_sides) ) + 1;
    push ( @rolls, $rolled );
    $total += $rolled;
    $roll_count++;
  }

  print "The rolls were: " . join( ', ', @rolls ) . "\n";
  print "They total: $total\n";
}
exit;
