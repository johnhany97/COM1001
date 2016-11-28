require "console_splash"

#Global Variables
$high_score = -1
$width_main = 14
$heigh_main = 9

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
end
    
def settings()
   
end

# Actually start the game
splash_screen()
