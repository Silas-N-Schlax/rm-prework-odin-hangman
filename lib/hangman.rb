require "colorize"
require_relative "hangman/play"
# Hangman Game
class Hangman
  def initialize
    @play = Play.new
  end

  def start
    print "Would you like to load a saved game? (y/n) -> ".colorize(:yellow)
    key = gets.chomp.downcase.chars.first
    key == "y" ? load_game : new_game
  end

  def load_game
    @play.load_game
    puts "Game Over!".colorize(:cyan)
  end

  def new_game
    @play.play
    puts "Game Over!".colorize(:cyan)
  end
end
