# Flood-It game
# This game was created as a COM1001 Assignment
#
# Copyright (C) 2016  John H. Ayad

#Include ruby gems
require "console_splash"
require "colorize"

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
        system "clear"
        # Initialize the splash screen
        splash = ConsoleSplash.new(15, 44)
        splash.write_header("FloodIt", "John Ayad", "1.0")
        splash.write_horizontal_pattern("*")
        splash.write_vertical_pattern("|")
        splash.write_center(-3, "<press Enter to continue>")
        # Run the splash screen *WATER EVERYWHERE*
        splash.splash
    end until gets == "\n"
    # Go to main menu
    main_menu(14, 9, -1)
end

# Main Menu
# Possible valid options here are:
# 1- Start a new game
# 2- Change Width/height of the game
# 3- Quit the game
# 4- View High Score
# Any invalid entry reloads the main menu and clears the screen before so
#
# Parameters:
#   Width => width of board
#   Height => Height of board
#   Highscore => Integer representing current highscore (Default: -1)
#
# Example call:
#   main_menu(14, 9, 10)
#
def main_menu(width, height, high_score)
    system "clear"
    # List of options for users
    puts "Main menu:"
    puts "s = Start Game"
    puts "c = Change Size"
    puts "q = Quit"
    # High Score
    if high_score == -1
        puts "No games played yet."
    else
        puts "Best game: #{high_score} turns"
    end
    print "Please enter your choice: "
    status = gets.chomp
    # Respond to user's entry
    if status.downcase == "s"
        # Let the games begin
        start_game(width, height, high_score)
    elsif status.downcase == "c"
        # Settings menu
        settings(width, height, high_score)
    elsif status.downcase == "q"
        # Good day to you sir/madam
        exit
    else 
        # Invalid entry => Reload main menu
        main_menu(width, height, high_score)
    end
end

# Settings menu
#
# Allows changing of width and height
#
# Will fail to update and keep on looping till received an input of more
# than 0 for both width and height
#
# Parameters:
#   width => Integer representing current width of board
#   height => Integer representing current height of board
#   high_score => Integer representing current highscore
#
# Example call:
#   settings(14, 9, 20)
#
def settings(width, height, high_score)
    # Start by width
    print "Width (Currently #{width})? "
    x = gets.chomp.to_i
    while x <= 0 do
        print "Width (Currently #{width})? "
        x = gets.chomp.to_i
    end
    # Then height
    print "Height (Currently #{height})? "
    y = gets.chomp.to_i
    while y <= 0 do
        print "Height (Currently #{height})? "
        y = gets.chomp.to_i
    end
    # Reset the high score since it's a new size
    high_score = -1 if (width != x) || (height != y)
    # Update the original variables
    width = x
    height = y
    # Return to main menu
    main_menu(width, height, high_score)
end

# The game caller
# 
# This function basically sets the board and calls the actual game
# 
# Parameters:
#   width => Integer representing width of board
#   height => Integer representing height of board
#   high_score => Integer representing current highscore
#
# Example call:
#   start_game(14, 9, 20)
#
def start_game(width, height, high_score)
    # Initalize the board
    board = get_board(width, height)
    # Start the game play
    game_play(board, false, 0, high_score)
end

# Returns an initialized board of the following colours
# Red, Green, Blue, Yellow, Magenta, Cyan
#
# Size of array is fully based on width & height set either by default or user
# Colours in array are saved as symbols so return is an array of symbols
#
# Parameters:
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
    color = [:red, :green, :blue, :yellow, :magenta, :cyan]
    #Initialize & return actual board array
    return Array.new(height) { Array.new(width) { color[rand(6)] } }
end

# Function to return a board used in Memorization
# By default initialized to -1
#
# Parameters:
#   width => Integer representing width of array
#   height => Integer representing height of array
#
# Returns:
#   An array filled with -1 of size provided
#
# Example call:
#   free_board(14, 9)
#
def free_board(width, height)
    return Array.new(height) { Array.new(width) { -1 }}
end

# The game itself
# Where all the magic takes place
#
# Parameters:
#   board => An array of symbols containing the colours of the blocks
#   game_won => Boolean representing current state of game (true if game is won)
#   counter_turns => Integer representing number of moves in current game
#   high_score => Integer representing the current highscore
#
# Example call:
#   game_play(board, false, 0, 10)
#
def game_play(board, game_won, counter_turns, high_score)
    system "clear"
    width = board[0].length
    height = board.length
    # Print colourized board
    print_board(board)
    # Game Info
    # - Number of moves played by user so far
    # - Current completion percentage
    puts "Turns: #{counter_turns}"
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
    if (!game_won) 
        # Take user input for next colour to flood with
        puts "Choose a colour: "
        colour_input = gets.chomp
        # Red
        if colour_input.downcase == "r" && board[0][0] != :red
            board = update_board(board, :red, board[0][0], 0, 0, free_board(width, height))
            game_won = true if completed_percent(board) == 100
            game_play(board, game_won, counter_turns + 1, high_score)
        # Green
        elsif colour_input.downcase == "g" && board[0][0] != :green
            board = update_board(board, :green, board[0][0], 0, 0, free_board(width, height))
            game_won = true if completed_percent(board) == 100
            game_play(board, game_won, counter_turns + 1, high_score)
        # Blue
        elsif colour_input.downcase == "b" && board[0][0] != :blue
            board = update_board(board, :blue, board[0][0], 0, 0, free_board(width, height))
            game_won = true if completed_percent(board) == 100
            game_play(board, game_won, counter_turns + 1, high_score)
        # Yellow
        elsif colour_input.downcase == "y" && board[0][0] != :yellow
            board = update_board(board, :yellow, board[0][0], 0, 0, free_board(width, height))
            game_won = true if completed_percent(board) == 100
            game_play(board, game_won, counter_turns + 1, high_score)
        # Cyan
        elsif colour_input.downcase == "c" && board[0][0] != :cyan
            board = update_board(board, :cyan, board[0][0], 0, 0, free_board(width, height))
            game_won = true if completed_percent(board) == 100
            game_play(board, game_won, counter_turns + 1, high_score)
        # Magenta
        elsif colour_input.downcase == "m" && board[0][0] != :magenta
            board = update_board(board, :magenta, board[0][0], 0, 0, free_board(width, height))
            game_won = true if completed_percent(board) == 100
            game_play(board, game_won, counter_turns + 1, high_score)
        # Quit the game itself
        elsif colour_input.downcase == "q"
            main_menu(width, height, high_score)
        else 
            # Invalid entry by user OR Entry is same colour already => Clear screen and wait for input
            game_play(board, game_won, counter_turns, high_score)
        end
    else
        # Show user he won in how many moves
        puts "You won after #{counter_turns} turns"
        # Update highscore if relevant or requires updating
        if high_score == -1
            high_score = counter_turns
        elsif high_score > counter_turns
            high_score = counter_turns
        end
        # Continue when Enter is pressed
        user_response = gets
        while user_response != "\n" do
            user_response = gets
        end
        # Return to main menu
        main_menu(width, height, high_score)
    end
end

# Board printing function
#
# Parameters:
#    board => The array of the current board
#
# Example call:
#    print_board(board)
def print_board(board)
    board.each do |row|
      row.each do |x|
        print "  ".colorize(:background => x)
      end
      puts
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
#   arr => Empty array of the same size as current board (Memorization)
#
# Returns:
#   An updated board (array of symbols)
#
# Example call:
#   update_board(board, :red, board[0][0], 0, 0, board2)
#
def update_board(board, x, old, i, j, arr)
    width = board[0].length
    height = board.length
    # Update Position
    board[i][j] = x
    # Memorize
    arr[i][j] = 0
    # Bottom
    if i < height - 1 && board[i+1][j] == old && arr[i + 1][j] == -1
        update_board(board, x, old, i + 1, j, arr)
    end
    # Top
    if i > 0 && board[i-1][j] == old && arr[i - 1][j] == -1
        update_board(board, x, old, i - 1, j, arr)
    end
    # Right
    if j < width - 1 && board[i][j+1] == old && arr[i][j + 1] == -1
        update_board(board, x, old, i, j + 1, arr)
    end
    # Left
    if j > 0 && board[i][j - 1] == old && arr[i][j - 1] == -1
        update_board(board, x, old, i, j - 1, arr)
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
    board.each do |row|
        row.each do |cell|
            num += 1 if cell == color_to_search
        end
    end
    # Total number of blocks in board
    total_blocks = board.length * board[0].length
    return (num * 100) / total_blocks
end

# Actually start the game
splash_screen