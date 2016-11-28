#Include ruby gems
require "console_splash"
require "colorize"

#Global Variables
$high_score = -1
$width_main = 14
$height_main = 9
$counter_turns = 0
$game_won = false

# Returns an initialized board of the following colours
# Red, Green, Blue, Yellow, Magenta, Cyan
# 
# Size of array is fully based on width & height set either by default or user
# Colours in array are saved as symbols so return is an array of symbols
# 
# Paremeters:
#   Width => width of board
#   Height => Height of board
# 
# Returns:
#   An initliazed array of symbols to be used in game
#   
# Example call:
#   get_board(5, 4)
#   get_board(20, 30)
#   
def get_board(width, height)
  #Initialize Array of colours
  color = Array.new(6)
  color[0] = :red
  color[1] = :green
  color[2] = :blue
  color[3] = :yellow
  color[4] = :magenta
  color[5] = :cyan
  #Initialize actual board array
  board = Array.new(height)
  for i in 0...board.size
    board[i] = Array.new(width)
  end
  #Fill the 2D board array
  for i in 0...board.size
      for j in 0...board[i].size
          board[i][j] = color[rand(6)]
      end
  end
  return board
end

# Splash Screen
# Displays a screen of size 44 x 15
# Takes user to main menu
# 
# Content:
#   - Author
#   - Name of game
#   - Game Version
#   - Instruction on how to continue (Pressing Enter)
# 
# Example call:
#   splash_screen()
#   
def splash_screen()
    begin
        # Clear screen
        system ("clear")
        # Initialize the splash screen
        splash = ConsoleSplash.new(15, 44)
        splash.write_header("FloodIt", "John Ayad", "1.0")
        splash.write_horizontal_pattern("*")
        splash.write_vertical_pattern("|")
        splash.write_center(-3, "<press Enter to continue>")
        # Run the splash screen
        splash.splash
    end until (gets() == "\n")
    # Go to main menu
    main_menu()
end

# Main Menu
# Possible valid options here are:
# 1- Start a new game
# 2- Change Width/height of the game
# 3- Quit the game
# 4- View High Score
# Any invalid entry reloads the main menu and clears the screen before so
# 
# Example call:
#   main_menu()
def main_menu()
    system ("clear")
    # List of options for users
    puts ("Main menu:")
    puts ("s = Start Game")
    puts ("c = Change Size")
    puts ("q = Quit")
    # High Score
    if ($high_score == -1)
        puts ("No games played yet.")
    else
        puts ("Best game: #$high_score turns")
    end
    print ("Please enter your choice: ")
    status = gets.chomp
    # Respond to user's entry
    if (status.downcase == "s")
        # Reset global variables in preperation for new game
        $counter_turns = 0
        $game_won = false
        # Let the games begin
        start_game()
    elsif (status.downcase == "c")
        # Settings menu
        settings()
    elsif (status.downcase == "q")
        # Good day to you sir/madam
        exit
    else 
        # Invalid entry => Reload main menu
        main_menu()
    end
end

def start_game()
    # Initalize the board
    board = get_board($width_main, $height_main)
    # Start the game play
    game_play(board)
end

# The game itself
# Where all the magic takes place
# 
# Parameters:
#   board => An array of symbols containing the colours of the blocks
# 
# Example call:
#   game_play(board)
#
def game_play(board)
    system ("clear")
    # Print colourized board
    for i in 0...board.size
        for j in 0...board[i].size
            print "  ".colorize(:background => board[i][j])
        end
        puts
    end
    # Game Info
    # - Number of moves played by user so far
    # - Current completion percentage
    puts "Turns: #$counter_turns"
    percentage = completed_percent(board)
    puts "Current completion: #{percentage}%"

    # Based on current condition
    # First possible condition: User hasn't won yet
    # Second possible condition: User has won
    # 
    # For First scenario:
    #   Inputs expected: r, g, b, c, y, m, q
    #   Response:
    #     If colour is not already the colour of the starting point, we'll
    #     update the board to flood with the new input
    #     If input is "q" we'll quit to main menu
    #     If input is invalid, clear screen and wait for new hopefully proper input
    # For Second scenario:
    #   Inputs expected: Enter by user
    #   User can see here that he won in X number of turns and is allowed to exit to main menu
    #   by presing the Enter key
    if (!$game_won) 
        # Take user input for next colour to flood with
        puts "Choose a colour: "
        colour_input = gets.chomp
        # Red
        if (colour_input.downcase == "r" && board[0][0] != :red)
            board = call_update(board, :red, board[0][0], 0, 0)
            $counter_turns += 1
            if (completed_percent(board) == 100)
                $game_won = true;
            end
            game_play(board)
        # Green
        elsif (colour_input.downcase == "g" && board[0][0] != :green)
            board = call_update(board, :green, board[0][0], 0, 0)
            $counter_turns += 1
            if (completed_percent(board) == 100)
                $game_won = true;
            end
            game_play(board)
        # Blue
        elsif (colour_input.downcase == "b" && board[0][0] != :blue)
            board = call_update(board, :blue, board[0][0], 0, 0)
            $counter_turns += 1
            if (completed_percent(board) == 100)
                $game_won = true;
            end
            game_play(board)
        # Yellow
        elsif (colour_input.downcase == "y" && board[0][0] != :yellow)
            board = call_update(board, :yellow, board[0][0], 0, 0)
            $counter_turns += 1
            if (completed_percent(board) == 100)
                $game_won = true;
            end
            game_play(board)
        # Cyan
        elsif (colour_input.downcase == "c" && board[0][0] != :cyan)
            board = call_update(board, :cyan, board[0][0], 0, 0)
            $counter_turns += 1
            if (completed_percent(board) == 100)
                $game_won = true;
            end
            game_play(board)
        # Magenta
        elsif (colour_input.downcase == "m" && board[0][0] != :magenta)
            board = call_update(board, :magenta, board[0][0], 0, 0)
            $counter_turns += 1 
            if (completed_percent(board) == 100)
                $game_won = true;
            end
            game_play(board)
        # Quit the game itself
        elsif (colour_input.downcase == "q")
            main_menu()
        else 
            # Invalid entry by user => Clear screen and wait for input
            game_play(board)
        end
    else
        # Show user he won in how many moves
        puts ("You won after #$counter_turns turns")
        # Update highscore if relevant or requires updating
        if ($high_score == -1)
          $high_score = $counter_turns
        elsif ($high_score > $counter_turns)
          $high_score = $counter_turns
        end
        # Continue when Enter is pressed
        user_response = gets()
        while (user_response != "\n") do
          user_response = gets()
        end
        # Return to main menu
        main_menu()
    end
end

# Flooding recursive function
# 
# Parameters:
#   board => The array of the current board
#   x => The colour to flood with
#   old => The colour of the 0 and 0 position
#   i => Row
#   j => Col
#
# Returns:
#   An updated board (array of symbols)
#   
# Example call:
#   call_update(board, :red, board[0][0], 0, 0)
#   
def call_update(board, x, old, i, j)
    # Update Position
    board[i][j] = x
    # Bottom
    if (i < $height_main - 1 && board[i+1][j] == old)
      call_update(board, x, old, i + 1, j)
    end
    # Top
    if (i > 0 && board[i-1][j] == old)
      call_update(board, x, old, i - 1, j)
    end
    # Right
    if (j < $width_main - 1 && board[i][j+1] == old)
      call_update(board, x, old, i, j + 1)
    end
    # Left
    if (j > 0 && board[i][j - 1] == old)
      call_update(board, x, old, i, j - 1)
    end
    # Return the updated board
    return board
end

# Function to return percentage of completion of game
# 
# Parameters:
#   board => Array of symbols
# 
# Returns:
#   Percentage of completion based on colour in 0 and 0 position
# 
# Example call:
#   completed_percent(board)
#   
def completed_percent(board)
    # Take note of colour in 0 and 0 position
    color_to_search = board[0][0]
    # Counter of how many blocks of same colour
    num = 0
    for i in 0...board.size
      for j in 0...board[i].size
          if (board[i][j] == color_to_search)
              num += 1
          end
      end
    end
    # Total number of blocks in board
    total_blocks = $width_main * $height_main
    return ((num * 100) / total_blocks)
end

# Settings menu
# 
# Allows changing of width and height
# 
# Will fail to update and keep on looping till received an input of more
# than 0 for both width and height
# 
# Example call:
#   settings()
#   
def settings(
    # Start by width
    puts ("Width (Currently #$width_main)? ")
    width = gets.chomp.to_i
    while (width < 0) do
        puts ("Width (Currently #$width_main)? ")
        width = gets.chomp.to_i
    end
    # Then height
    puts ("Height (Currently #$height_main)? ")
    height = gets.chomp.to_i
    while (height < 0) do
        puts ("Height (Currently #$height_main)? ")
        height = gets.chomp.to_i
    end
    # Update global variables
    $width_main = width
    $height_main = height
    # Return to main menu
    main_menu()
end

# Actually start the game
splash_screen()
