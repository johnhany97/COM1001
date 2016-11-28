require "console_splash"
require "colorize"

#Global Variables
$high_score = -1
$width_main = 14
$height_main = 9
$counter_turns = 0

def get_board(width, height)
  # beta implementation
  color = Array.new(6)
  color[0] = :red
  color[1] = :blue
  color[2] = :yellow
  color[3] = :cyan
  color[4] = :magenta
  board = Array.new(height)
  for i in 0...board.size
    board[i] = Array.new(width)
  end
  for i in 0...board.size
      for j in 0...board[i].size
          board[i][j] = color[rand(5)]
      end
  end
  return board
end

# Splash Screen
def splash_screen()
    begin
        system ("clear")
        splash = ConsoleSplash.new(15, 44)
        splash.write_header("FloodIt COM1001 Assignment", "Johnhany97", "0.0.0")
        splash.write_horizontal_pattern("*")
        splash.write_vertical_pattern("|")
        splash.write_center(-3, "<press Enter to continue>")
        splash.splash
    end until (gets() == "\n")
    main_menu()
end
    
def main_menu()
    system ("clear")
    puts ("Main menu:")
    puts ("s = Start Game")
    puts ("c = Change Size")
    puts ("q = Quit")
    if ($high_score == -1)
        puts ("No games played yet.")
    else
        puts ("Best game: #$high_score turns")
    end
    print ("Please enter your choice: ")
    status = gets.chomp
    
    if (status.downcase == "s")
        counter_turns = 0
        start_game()
    elsif (status.downcase == "c")
        settings()
    elsif (status.downcase == "q")
        exit
    else 
        main_menu()
    end
end

def start_game()
    board = get_board($width_main, $height_main)
    game_play(board)
end
    
def game_play(board)
    system ("clear")
    for i in 0...board.size
        for j in 0...board[i].size
            print "  ".colorize(:background => board[i][j])
        end
        puts
    end
    puts "Turns: #$counter"
    percentage = completed_percent(board)
    puts "Current completion: #{percentage}%"
    puts "Choose a colour: "
    colour_input = gets.chomp
    if (colour_input.downcase == "r")
        board = call_update(board, :red, board[0][0], 0, 0)
        game_play(board)
    elsif (colour_input.downcase == "b")
        board = call_update(board, :blue, board[0][0], 0, 0)
        game_play(board)
    elsif (colour_input.downcase == "y")
        board = call_update(board, :yellow, board[0][0], 0, 0)
        game_play(board)
    elsif (colour_input.downcase == "c")
        board = call_update(board, :cyan, board[0][0], 0, 0)
        game_play(board)
    elsif (colour_input.downcase == "m")
        board = call_update(board, :magenta, board[0][0], 0, 0)
        game_play(board)
    elsif (colour_input.downcase == "q")
        main_menu()
    else 
        game_play(board)
    end
end
  
def call_update(board, x, old, i, j)
    board[i][j] = update_board(board, x, old, i, j)
    if (i < $height_main - 1 && board[i+1][j] == old)
      call_update(board, x, old, i + 1, j)
    end
    if (j < $width_main - 1 && board[i][j+1] == old)
      call_update(board, x, old, i, j + 1)
    end
    return board
end

def update_board(board, x, old, i, j)
   return x
end
    
def completed_percent(board)
    color_to_search = board[0][0]
    num = 0
    for i in 0...board.size
      for j in 0...board[i].size
          if (board[i][j] == color_to_search)
              num += 1
          end
      end
    end
    total_blocks = $width_main * $height_main
    return ((num * 100) / total_blocks)
end

def settings()
   
end

# Actually start the game
splash_screen()
