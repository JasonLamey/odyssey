Classroom Project Program
  Contest Management Software
    This software is a project program designed to help teach the concepts
    of scalars, lists, hashes, logic, loops, subroutines, and other basic
    concepts through practical use. This version of the program is but one
    version of the program. The students are expected to write their own
    versions of the program while fulfilling the same functionality and
    program goals.

    Expected functionality:

    *   A help command that displays the available program commands.

    *   A status command that displays the data that has been given to the
        program.

    *   An add game command, granting the ability to add game titles to an
        array.

    *   An add player command, granting the ability to add players, with
        their names and scores, to a hash, and associated to each game.

    *   A list games command, displaying all game titles that have been
        added.

    *   A list players command, displaying all player data that has been
        added.

    *   An exit command, to end the program.

    *   The ability to tell the program the name of the competition.

    *   The requirement that game titles must be defined before players can
        be added.

    This software makes use of a while loop that is always "true", so that
    it stays running, and looking for more input from the user. If the user
    issues an "exit" command, the loop will end and the program will exit.

FUNCTIONS
  prompt_for_command()
    Prints a command prompt to the user, and accepts STDIN from the user.
    Returns a chomped string to the caller.

  add_game()
    Adds the game title to the @games array. Returns a string to the caller,
    containing either a success message or an error message.

  add_player()
    Prompts the user with questions about the player to add the player to
    the %players hash. Returns a string containing either a success message
    or an error message.

  list_games()
    Returns a string containing all games that have been added to the @games
    array.

  list_players()
    Returns a string containing all players that have been added to the
    %players hash.

  list_players_by_score()
    Returns a string containing all players that have been added to the
    %players hash, sorted by score.

  get_status()
    Returns a string containing the full status of all data that has been
    entered into the program thus far.

PRIVATE FUNCTIONS
  _game_exists()
    A routine that checks for the existence of a game title within the
    @games array, and returns a boolean value.

