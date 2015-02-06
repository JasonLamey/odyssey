#!d:/strawberry/bin/perl.exe

use strict;
use warnings;
use 5.010;
use List::MoreUtils;

say "Welcome to the Math Game!";
say '';

our $correct   = 0;
our $incorrect = 0;

our %commands = (
  1 => 'Add',
  2 => 'Subtract',
  3 => 'Multiply',
  4 => 'Divide',
  5 => 'Algebra',
  6 => 'Exit',
);

our $game_command  = undef;
our $num_questions = 0;

while ( 1 )
{
  my $rv = get_game_type();
  if ( $rv )
  {
    next;
  }

  else
  {
    play_math( lc( $game_command ), $num_questions );
  }

  $correct   = 0;
  $incorrect = 0;
}


exit;

# FUNCTIONS

sub play_math
{
  my ( $game_command, $num_questions ) = @_;

  for ( my $i = 1; $i <= $num_questions; $i++ )
  {
    say "QUESTION #$i of $num_questions:";

    my $num1 = int( rand( 100 ) ) + 1;
    my $num2 = int( rand( 100 ) ) + 1;

    if ( $game_command eq 'add' )
    {
      add( $num1, $num2 );
    }
    elsif ( $game_command eq 'subtract' )
    {
      subtract( $num1, $num2 );
    }
    elsif ( $game_command eq 'multiply' )
    {
      multiply( $num1, $num2 );
    }
    elsif ( $game_command eq 'divide' )
    {
      divide( $num1, $num2 );
    }
    elsif ( $game_command eq 'algebra' )
    {
      algebra( $num1, $num2 );
    }
    else
    {
      say "I have no idea what you mean by '$game_command'.";
      last;
    }
  }

  say '';
  say "Game over. Let's see how you did!";
  say "You scored $correct out of $num_questions. (Missed $incorrect.)";
  if ( $correct == $num_questions )
  {
    say "PERFECT SCORE!!  GREAT JOB!  Keep up the good work.";
  }
  elsif ( $correct > $num_questions * 0.75 )
  {
    say "Doing well!  Near perfect job!  Keep practicing to improve your skills.";
  }
  elsif ( $correct > $num_questions * 0.5 && $correct <= $num_questions * 0.75 )
  {
    say "Not bad. You need to brush up on your skills a bit.";
  }
  else
  {
    say "Ouch. I know you can do better than that because you're smart. Keep practicing!";
  }
  say '';
}

sub add
{
  my ( $num1, $num2 ) = @_;
  my $answer = _do_math( $num1, $num2, '+' );
  say "$num1 + $num2 = ?";
  prompt( 'What is the sum? ' );
  my $guess = <STDIN>;
  chomp $guess;

  check_answer( $guess, $answer );
}

sub subtract
{
  my ( $num1, $num2 ) = @_;
  my $answer = _do_math( $num1, $num2, '-' );
  say "$num1 - $num2 = ?";
  prompt( 'What is the difference? ' );
  my $guess = <STDIN>;
  chomp $guess;

  check_answer( $guess, $answer );
}

sub multiply
{
  my ( $num1, $num2 ) = @_;
  my $answer = _do_math( $num1, $num2, '*' );
  say "$num1 x $num2 = ?";
  prompt( 'What is the product? ' );
  my $guess = <STDIN>;
  chomp $guess;

  check_answer( $guess, $answer );
}

sub divide
{
  my ( $num1, $num2 ) = @_;
  my $answer = _do_math( $num1, $num2, '/' );
  say "$num1 / $num2 = ?";
  prompt( 'What is the quotient (to two decimal places, if not a whole number)? ' );
  my $guess = <STDIN>;
  chomp $guess;

  check_answer( $guess, $answer );
}

sub algebra
{
  my ( $num1, $num2 ) = @_;

  my $op //= _get_random_op();

  my $answer = _do_math( $num1, $num2, $op );
  say "$num1 $op ? = $answer";
  prompt( 'What is the missing number? ' );
  my $guess = <STDIN>;
  chomp $guess;

  check_answer( $guess, $num2 );
}

sub check_answer
{
  my ( $guess, $answer ) = @_;

  if ( $guess == $answer )
  {
    $correct++;
    say "CORRECT! GREAT JOB!!";
  }
  else
  {
    $incorrect++;
    say "Oooh, good guess. But the answer was >$answer<.  Try again.";
  }
}

sub get_game_type
{
  say "What kind of math are you practicing today? ";
  say '(' . join(', ', map { $commands{$_} } 1 .. 6 ) . ')';
  prompt();
  $game_command = <STDIN>;
  chomp $game_command;

  my $exists = 0;
  foreach my $key ( keys %commands )
  {
    $exists = 1 if $commands{$key} eq ucfirst( $game_command );
  }

  if ( $exists == 0 )
  {
    say "Don't know what that is.  Say again?";
    return -1;
  }

  if ( lc( $game_command ) eq 'exit' )
  {
    say "Good bye!";
    exit;
  }

  say "How many questions would you like to be asked? ";
  $num_questions = <STDIN>;
  chomp $num_questions;
  $num_questions //= 1;

  return;
}

sub prompt
{
  my ( $text ) = @_;

  $text //= '';

  print "$text> ";
}

sub _do_math
{
  my ( $num1, $num2, $op ) = @_;

  my $answer = undef;
  $answer = eval ( "$num1 $op $num2" );
  say $@ if $@;

  #say "DEBUG (pre): $answer = $num1 $op $num2";

  if ( $answer =~ m/\./ )
  {
    $answer = sprintf( "%.2f", $answer );
  }

  #say "DEBUG (post): $answer = $num1 $op $num2";

  return $answer;
}

sub _get_random_op
{
  my @op_keys = ( qw/ a s m d / );
  my %ops = (
    a => '+',
    s => '-',
    m => '*',
    d => '/',
  );
  my $id = int( rand( 4 ) );
  return $ops{$op_keys[$id]};
}

