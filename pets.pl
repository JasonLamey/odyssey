#!d:\strawberry\bin\perl.exe

print 'How many pets would you like? ';
$num_pets = <STDIN>;
chomp $num_pets;

print 'What kind of pet(s) would you like? ';
$pet_type = <STDIN>;
chomp $pet_type;

print "\n";
print "Okay, you now have $num_pets $pet_type";
if ( $num_pets != 1 )
{
  print 's';
}
print "\n";
