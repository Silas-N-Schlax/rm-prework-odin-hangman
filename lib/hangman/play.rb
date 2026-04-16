require "colorize"
require_relative "board"
require_relative "new_word"
require_relative "save"
require_relative "load"
# Play Hangman and control everything
class Play
  def initialize
    @board = Board.new
    @secret_word = NewWord.new.word
    p @secret_word
    @board.secret_word_length(@secret_word.chars)
    @wrong_guesses = 0
  end

  def load_game
    saved_game = Load.new.load
    @wrong_guesses = saved_game["wrong_guesses"]
    @secret_word = saved_game["secret_word"]
    @board.load_board(saved_game)
    @board.send_board
    puts "Game loaded!".colorize(:yellow)
    play
  end

  def play
    @board.send_board
    input = user_input
    return nil if input == "@"

    right_letter?(input) ? right_guess(input) : wrong_guess(input)
    play unless game_over?
    @board.send_board if game_over?
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
    indexes = @secret_word.chars.each_index.select { |i| @secret_word[i] == guess }
    @board.update_revealed_letters(guess, indexes)
  end

  def user_input(msg = "What letter would you like to guess? (save = @) -> ", color = :blue)
    print msg.colorize(color)
    input = gets.chomp.downcase.chars.first
    msg = "Enter a LETTER, or a letter you have not guessed (save = @) -> "
    input = user_input(msg, :red) unless valid_input?(input) || input == "@"
    save_game if input == "@"
    input
  end

  def valid_input?(input)
    true if ("a".."z").to_a.include?(input) && !@board.letters_guessed.include?(input.upcase)
  end

  def game_over?
    true if @wrong_guesses >= 7 || @board.letters_reavealed.all? { |item| item != "_" }
  end

  def save_game
    print "This will erase any other saved game. Do you want to continue? (y/n) -> ".colorize(:light_red)
    play unless gets.chomp.downcase.chars.first == "y"
    game_data = {
      "wrong_guesses" => @wrong_guesses,
      "letters_guessed" => @board.letters_guessed,
      "letters_reavealed" => @board.letters_reavealed,
      "secret_word" => @secret_word
    }
    Save.new.save(game_data)
    puts "Game saved! See you later!".colorize(:yellow)
  end
end
