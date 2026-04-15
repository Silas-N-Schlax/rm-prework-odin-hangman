# Opens words.txt, and picks 1 word that is between 5-12 chars long.
class NewWord
  attr_reader :word

  def initialize
    @word = random_word
  end

  def random_word
    words = load_words
    word = words.sample
    word = random_word unless word.length > 4 && word.length < 13
    word
  end

  def load_words
    file_path = File.join(__dir__, "words.txt")
    File.read(file_path).split("\n")
  end
end
