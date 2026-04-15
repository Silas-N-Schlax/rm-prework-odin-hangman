require "colorize"
# Hangman Game
class Hangman
  def start
    print "Would you like to load a saved game? (y/n) -> ".colorize(:blue)
    key = gets.chomp.downcase.chars.first
    key == "y" ? load_game : new_game
  end

  def load_game
    puts "load game"
  end

  def new_game
    puts "new game"
  end
end
