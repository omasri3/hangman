require 'yaml'
require 'pry'
require_relative 'lib/Hangman.rb'
require 'json'
hangman = HANGMAN.new()

puts "Welcome to the game of hangman! You have 6 guesses to guess the word correctly!"
puts "\n\n"
guessing_string =  '___  ' * hangman.random_word.length
puts guessing_string
puts "Guess a letter! If you want to save your game for later, type 'save'! If you want to start a previous game, type 'load' followed by the filename"


letters_guessed = ''
guess_incorrect = false
word_complete = false
letters_guessed_right = 0

puts hangman.random_word

while hangman.guesses_remaining > 0

  hangman.hangman()
  letter_guess = gets.downcase.chomp

  if letter_guess.downcase == 'save'
    game_data = {guesses_remaining: hangman.guesses_remaining, 
                  random_word: hangman.random_word,
                  letters_guessed: letters_guessed,
                  letters_guessed_right: letters_guessed_right,
                  guessing_string: guessing_string
                }
    File.open("hangman_save.json", "w") {|f| f.puts game_data.to_json}
    break
  elsif letter_guess.downcase == 'load'
    puts "Input the file name"
    filename = gets.downcase.chomp
    file = File.open filename
    data = JSON.load file
    hangman.guesses_remaining = data["guesses_remaining"]
    hangman.random_word = data["random_word"]
    letters_guessed = data["letters_guessed"]
    letters_guessed_right = data["letters_guessed_right"]
    guessing_string = data["guessing_string"]
  elsif hangman.random_word.include?(letter_guess)
    letter_array = hangman.random_word.split("")
    letter_array.each_with_index do |val, index|
      if val == letter_guess
      guessing_string[index*5 ... index*5+5] = "  #{val}  "
      letters_guessed_right += 1
      end
    end
  else
    letters_guessed = letters_guessed.concat("#{letter_guess} ")
    hangman.wrong_guess
  end

  puts guessing_string

  if letters_guessed_right == hangman.random_word.length
    puts "Congratulations! You have successfully guessed the word: #{hangman.random_word}"
    break
  elsif hangman.guesses_remaining == 0
    puts "So sorry, but you lose the game of hangman! The word was #{hangman.random_word}"
  end

  puts "\n\n"
  puts "Letters you have already guessed incorrect: #{letters_guessed}"
  puts "Guess another letter!"
end