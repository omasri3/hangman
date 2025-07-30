require 'json'

class HANGMAN

  attr_accessor :guesses_remaining, :random_word

  def initialize()
    words = []
    words = File.read('lib/google-10000-english-no-swears.txt').split.select{|word| word.length >= 5 && word.length <= 12}
    number_of_qualifying_words = words.length
    @guesses_remaining = 6
    rand_seed = Random.new
    @random_word = words[rand_seed.rand(0..number_of_qualifying_words-1)]
  end

  def to_json()
    File.open("hangman_save.json", "w")
    JSON.dump({
      :guesses_remaining => @guesses_remaining,
      :random_word => @random_word
    })
  end

  def self.from_json(string)
    data = JSON.load string
    self.new(data[:guesses_remaining], data[:random_word])
  end

  def wrong_guess
    @guesses_remaining -= 1
  end

  def hangman()
    if @guesses_remaining == 6
      puts <<-HANGMAN
      __________
      |        |
      |
      |
      |
      |
      |
      |
      |
      __________
      HANGMAN
    elsif @guesses_remaining == 5
     puts <<-HANGMAN
      __________
      |        |
      |        O
      |
      |
      |
      |
      |
      |
      __________
      HANGMAN
    elsif @guesses_remaining == 4
     puts <<-HANGMAN
      __________
      |        |
      |        O
      |        |
      |        |
      |
      |
      |
      |
      __________
      HANGMAN
    elsif @guesses_remaining == 3
      puts <<-HANGMAN
      __________
      |        |
      |        O
      |      / |
      |     /  |
      |
      |
      |
      |
      __________
      HANGMAN
    elsif @guesses_remaining == 2
      puts <<-HANGMAN
      __________
      |        |
      |        O
      |      / | \
      |     /  |  \
      |
      |
      |
      |
      __________
      HANGMAN
    elsif @guesses_remaining == 1
      puts <<-HANGMAN
      __________
      |        |
      |        O
      |      / | \
      |     /  |  \
      |       /
      |      /
      |
      |
      __________
      HANGMAN
    elsif @guesses_remaining == 0
      puts <<-HANGMAN
      __________
      |        |
      |        O
      |      / | \
      |     /  |  \
      |       /  \
      |      /    \
      |
      |
      __________
      HANGMAN
    end
  end
end