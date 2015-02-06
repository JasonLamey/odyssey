#!d:\strawberry\perl\bin\perl.exe

######################################
# This program is designed to give
# students new to the Perl programming
# language a basic understanding of
# programming.
# Author: Jason Lamey - Dec. 2014
######################################

=pod

=head1 Classroom Project Program

=head2 Contest Management Software

This software is a project program designed to help teach the concepts of
scalars, lists, hashes, logic, loops, subroutines, and other basic concepts
through practical use. This version of the program is but one version of the
program.  The students are expected to write their own versions of the program
while fulfilling the same functionality and program goals.

Expected functionality:

=over 4

=item *

A help command that displays the available program commands.

=item *

A status command that displays the data that has been given to the program.

=item *

An add game command, granting the ability to add game titles to an array.

=item *

An add player command, granting the ability to add players, with their names and scores, to a hash, and associated to each game.

=item *

A list games command, displaying all game titles that have been added.

=item *

A list players command, displaying all player data that has been added.

=item *

An exit command, to end the program.

=item *

The ability to tell the program the name of the competition.

=item *

The requirement that game titles must be defined before players can be added.

=back

=cut

use 5.010; # Allows the use of "say".

my %commands = (
  'help'          => 1,
  'status'        => 1,
  'add game'      => 1,
  'add player'    => 1,
  'list games'    => 1,
  'list players'  => 1,
  'exit'          => 1,
);

say 'Welcome to the Game Competition Management Program.';
print "\n";

# Set up global-level variables.
our $competition_name = undef;
our @games            = ();
our %players          = ();

print 'What is the name of this game competition? ';
$competition_name = <STDIN>;
chomp( $competition_name );
say 'Setting the competition name to >' . $competition_name . '<.';
print "\n";
say 'Now you can add games and players. Type "help" to see a list of commands.';
print "\n";

=pod

This software makes use of a while loop that is always "true", so that it stays
running, and looking for more input from the user.  If the user issues an "exit"
command, the loop will end and the program will exit.

=cut

while ( 1 )
{
  my $command = prompt_for_command();
  if ( ! defined $command || $command eq '' )
  {
    say 'Wha?';
    print "\n";
  }
  elsif ( ! exists $commands{ lc( $command ) } )
  {
    say 'I have no idea what >' . $command . '< means.';
    print "\n";
  }
  else
  {
    if ( lc( $command ) eq 'help' )
    {
      say 'Available commands are:';
      print "\t" . join( ', ', sort ( keys ( %commands ) ) ) . "\n\n";
    }
    elsif ( lc( $command ) eq 'status' )
    {
      say get_status();
    }
    elsif ( lc( $command ) eq 'add game' )
    {
      say add_game();
    }
    elsif ( lc( $command ) eq 'add player' )
    {
      say add_player();
    }
    elsif ( lc( $command ) eq 'list players' )
    {
      say list_players();
    }
    elsif ( lc( $command ) eq 'list games' )
    {
      say list_games();
    }
    elsif ( lc( $command ) eq 'exit' )
    {
      say 'Quitting. Please note: This program does not save data to disk.';
      sleep 3;
      exit 0;
    }
  }
}


=head1 FUNCTIONS


=head2 prompt_for_command()

Prints a command prompt to the user, and accepts STDIN from the user. Returns a
chomped string to the caller.

=cut

sub prompt_for_command
{
  print "What is thy bidding, my master? ";
  my $command = <STDIN>;
  chomp( $command );

  return $command;
}


=head2 add_game()

Adds the game title to the C<@games> array. Returns a string to the caller, containing
either a success message or an error message.

=cut

sub add_game
{
  print "\tWhat is the game's name? ";
  my $name = <STDIN>;
  chomp( $name );

  if ( ! defined $name || $name eq '' )
  {
    return 'ERROR: You must enter the name of a game.';
  }

  if ( _game_exists( $name ) )
  {
    return "ERROR: The game >$name< has already been added to this competition.";
  }

  push( @games, $name );
  return 'Added >' . $name . '< to the list of games.';
}


=head2 add_player()

Prompts the user with questions about the player to add the player to the C<%players> hash.
Returns a string containing either a success message or an error message.

=cut

sub add_player
{
  if ( scalar( @games ) < 1 )
  {
    return 'ERROR: You must add games first before you can add players.';
  }

  print "\t" . list_games();
  print "\tTo what game are you adding a player? ";
  my $game = <STDIN>;
  chomp( $game );

  if ( ! _game_exists( $game ) )
  {
    return "ERROR: The game >$game< hasn't been added to this competition.";
  }

  print "\tWhat is the player's name? ";
  my $name = <STDIN>;
  chomp( $name );

  if ( ! defined $name || $name eq '' )
  {
    return 'ERROR: You must enter the name of the player.';
  }

  if ( exists $players{ lc( $game ) } )
  {
    foreach my $player ( keys %{ $players{ lc( $game ) } } )
    {
      if ( lc( $name ) eq lc( $player ) )
      {
        return 'ERROR: Player >' . $name . '< already exists for this game.';
      }
    }
  }

  print "\tWhat is the player's score? ";
  my $score = <STDIN>;
  chomp( $score );

  if ( ! defined $score || $score eq '' )
  {
    return 'ERROR: You must enter a score for the player.';
  }

  if ( $score =~ m/\D/ )
  {
    return 'ERROR: You must enter a numeric score!.';
  }

  $players{ lc( $game ) }{$name} = $score;
  return 'Added >' . $name . '< to >' . $game . '< with a score of >' . $score . '<.';
}


=head2 list_games()

Returns a string containing all games that have been added to the C<@games> array.

=cut

sub list_games
{
  my $output = '';

  if ( scalar( @games ) < 1 )
  {
    $output .= "No games defined.\n";
    return $output;
  }
  else
  {
    $output .= 'Current Games: ' . join( ', ', sort { $a cmp $b || $a <=> $b } @games ) . "\n";
  }

  return $output;
}


=head2 list_players()

Returns a string containing all players that have been added to the C<%players> hash.

=cut

sub list_players
{
  my $output = '';

  if ( scalar( keys( %players ) ) < 1 )
  {
    $output .= "No players defined.\n";
  }
  else
  {
    $output .= "Current Players:\n";
    foreach my $game ( sort { $a cmp $b } @games )
    {
      $output .= $game . "\n";
      $output .= "------------------------------------\n";
      foreach my $player ( sort { $a cmp $b } keys( %{ $players{ lc( $game ) } } ) )
      {
        $output .= sprintf( "Player: %10s  Score: %6d\n", $player, $players{ lc( $game ) }{$player} );
      }
      $output .= "\n";
    }
  }

  return $output;
}


=head2 list_players_by_score()

Returns a string containing all players that have been added to the C<%players> hash, sorted by score.

=cut

sub list_players_by_score
{
  my $output = '';

  if ( scalar( keys( %players ) ) < 1 )
  {
    $output .= "No players defined.\n";
  }
  else
  {
    foreach my $game ( sort { $a cmp $b } @games )
    {
      my @player_scores = ();

      $output .= 'Final Scores for ' . $game . "\n";
      $output .= "------------------------------------\n";
      foreach my $player ( keys %{ $players{ lc( $game ) } } )
      {
        push( @player_scores, { name => $player, score => $players{ lc( $game ) }{$player} } );
      }

      foreach $player ( sort { $b->{score} <=> $a->{score} } @player_scores )
      {
        $output .= sprintf( "Player: %10s  Score: %6d\n", $player->{name}, $player->{score} );
      }
      $output .= "\n";
    }
  }

  return $output;
}


=head2 get_status()

Returns a string containing the full status of all data that has been entered into the program thus far.

=cut

sub get_status
{
  my $output = "\n" . $competition_name . ' Status Screen' . "\n";
  $output   .= "============================================\n";

  # Games
  $output .= list_games();
  $output .= "\n";

  # Players
  $output .= list_players_by_score();

  return $output;
}


=head1 PRIVATE FUNCTIONS


=head2 _game_exists()

A routine that checks for the existence of a game title within the C<@games> array, and
returns a boolean value.

=cut

sub _game_exists
{
  my ( $game ) = @_;

  my $exists = 0;
  foreach my $existing ( @games )
  {
    if ( lc( $game ) eq lc( $existing ) )
    {
      $exists = 1;
      last;
    }
  }

  return $exists;
}
