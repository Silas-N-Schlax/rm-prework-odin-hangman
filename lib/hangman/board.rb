# Generate, Manager, Update, and Send board
class Board
  attr_accessor :letters_guessed, :letters_revealed, :pl

  def initialize
    @body_parts = ["O", "|", "/", "\\", "|", "/", "\\"]
    @pl = Array.new(7, " ") # parts lost
    @letters_guessed = Array.new(26, "_")
    @letters_reavealed = Array.new(12, "_")
  end

  def update_parts_lost(lost)
    for i in 0..lost
      @pl[i] = @body_parts[i]
    end
  end

  def update_revealed_letters(letter, idx)
    @letters_reavealed[idx] = letter.upcase
  end

  def update_guessed_letters(letter)
    alphabet = ("a".."z").to_a
    @letters_guessed[alphabet.index(letter)] = letter.upcase
  end

  def send_board
    puts generate_board
  end

  def generate_board
    board = []
    hangman = generate_hangman
    new_array = @letters_guessed.each_slice(5).to_a
    hangman.each_with_index do |row, i|
      board.push(
        [row, generate_guessed_letters(new_array[i])].join
      )
    end
    join_boards(board)
  end

  def join_boards(board)
    bottom_board = generate_bottom_board
    bottom_board.each { |item| board.push(item) }
    board.unshift("╔═══════════════╦═════════════╗")
    board
  end

  def generate_bottom_board
    revealed = []
    @letters_reavealed.map { |letter| revealed.push("#{letter} ") }
    ["╠═══════════════╩═════════════╣", ["║   ", revealed.join, "  ║"].join, "╚═════════════════════════════╝"]
  end

  def generate_guessed_letters(row)
    "  #{row[0]} #{row[1] || ' '} #{row[2] || ' '} #{row[3] || ' '} #{row[4] || ' '}  ║"
  end

  def generate_hangman
    [
      "║    ╔════╗     ║",
      "║    ║    #{@pl[0]}     ║",
      "║    ║   #{@pl[2]}#{@pl[1]}#{@pl[3]}    ║",
      "║    ║    #{@pl[4]}     ║",
      "║    ║   #{@pl[5]} #{@pl[6]}    ║",
      "║  ══╩══        ║"
    ]
  end
end
