require "colorize"
require_relative "board"
require_relative "new_word"
# Play Hangman and control everything
class Play
  def initialize
    @board = Board.new
    @secret_word = NewWord.new.word
    @board.secret_word_length(@secret_word.chars)
    @wrong_guesses = 0
  end

  def play
    input = user_input
    right_letter?(input) ? right_guess(input) : wrong_guess(input)
    @board.send_board
    play unless game_over?
    puts "Game Over!".colorize(:orange)
  end

  def right_letter?(guess)
    true if @secret_word.chars.include?(guess)
  end

  def wrong_guess(guess)
    @board.update_guessed_letters(guess)
    @wrong_guesses += 1
    @board.update_parts_lost(@wrong_guesses)
  end

  def right_guess(guess)
    @board.update_revealed_letters(guess, @secret_word.chars.index(guess))
  end

  def user_input(msg = "What letter would you like to guess? -> ", color = :blue)
    print msg.colorize(color)
    input = gets.chomp.downcase.chars.first
    msg = "Enter a LETTER, or a letter you have not guessed -> "
    input = user_input(msg, :red) unless valid_input?(input)
    input
  end

  def valid_input?(input)
    true if ("a".."z").to_a.include?(input) && !@board.letters_guessed.include?(input.upcase)
  end

  def game_over?
    true if @wrong_guesses >= 7 || @board.letters_reavealed.all? { |item| item != "_" }
  end
end

play = Play.new
p play.play
