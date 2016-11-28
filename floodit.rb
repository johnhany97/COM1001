require "console_splash"

#Global Variables
$high_score = -1;

def get_board(width, height)
  # TODO: Implement this method
  #
  # This method should return a two-dimensional array.
  # Each element of the array should be one of the
  # following values (These are "symbols", you can use
  # them like constant values):
  # :red
  # :blue
  # :green
  # :yellow
  # :cyan
  # :magenta
  #
  # It is important that this method is used because
  # this will be used for checking the functionality
  # of your implementation.
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
        puts ("Best game: #$highScore turns")
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

end
    
def settings()
    
end

# Actually start the game
splash_screen()
