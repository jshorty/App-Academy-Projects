require 'byebug'

class Hangman
  attr_reader :player1, :player2

  def initialize
    @player1 = nil
    @player2 = nil
    @word_length = nil
    @board = []
  end

  def play
    setup
    player2.get_guess(@word_length, @board)
  end

  def setup
    create_new_players(intro_input)
    @word_length = player1.word_length
    @word_length.times {@board << nil}
    display_word_length
    display_board
  end

  def create_new_players(mode)
    case mode
      when 1 then @player1, @player2 = HumanPlayer.new, ComputerPlayer.new
      when 2 then @player1, @player2 = ComputerPlayer.new, HumanPlayer.new
      when 3 then @player1, @player2 = ComputerPlayer.new, ComputerPlayer.new
    end
  end

  def intro_input
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    puts "Welcome to Hangman! Please choose how you'd like to play:"
    puts "1. A computer player guesses your secret word (1)"
    puts "2. You guess a computer player's secret word (2)"
    puts "3. Watch two computers play against one another (3)"
    input = gets.chomp
    until ["1", "2", "3"].include?(input)
      print "Please select a valid game mode! (1-3) "
      input = gets.chomp
    end
    return input.to_i
  end

  def display_word_length
    puts "The secret word is #{@word_length} letters long."
  end

  def render_board
    rendered_board = []
    letter_numbers = []
    @board.each_with_index do |letter, i|
      if letter.nil?
        rendered_board << "_"
      else
        rendered_board << letter.to_s.upcase
      end
      letter_numbers << (i + 1).to_s
    end
    rendered_board = rendered_board.join(" ").split("")
    letter_numbers = letter_numbers.join(" ").split("")
    [rendered_board, letter_numbers]
  end

  def display_board
    render_board[0].each {|char| print char}
    print "\n"
    render_board[1].each {|char| print char}
    print "\n"
  end
end

class HumanPlayer
  def initialize
    @word_length = nil
    @guessed_letters = []
  end

  def word_length
    print "Please choose a secret word and enter its length: "
    input = gets.chomp
    until (1..25).include?(input.to_i)
      print "Please enter a valid word length (1-25):"
    end
    @word_length = input.to_i
  end

  def get_guess(word_length, board)
    print "Please guess a letter (A-Z) "
    guess = gets.chomp
    while @guessed_letters.include?(guess.downcase.to_sym)
      until ("a".."z").to_a.include?(guess.downcase)
        print "Please enter a valid letter! (A-Z) "
        guess = gets.chomp
      end
      print "You already guessed that letter! Try again. (A-Z) "
      guess = gets.chomp
    end

    @guessed_letters << guess.to_sym
    guess
  end
end

class ComputerPlayer
  def initialize
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @word = nil
    @guessed_letters = []
    @possible_words = []
  end

  def word_length
    dictionary =
    @word = @dictionary.sample
    @word.length
  end

  def random_guess
    if @guessed_letters.length == 26
      return ("a".."z").to_a.sample.to_sym
    else
      guess = ("a".."z").to_a.sample
      while @guessed_letters.include?(guess.to_sym)
        guess = ("a".."z").to_a.sample
      end
      @guessed_letters << guess.to_sym
      guess.to_sym
    end
  end

  def get_guess(word_length, board)
    if board.none?
      @possible_words = @dictionary.select {|word| word.length == word_length}
    else
      update_possible_words(board)
    end
    get_most_frequent_letter(board).to_sym
  end



  def update_possible_words(board)
    found_letters = {}
    board.each_with_index do |letter, i|
      found_letters[i] = letter.to_s.downcase unless letter.nil?
    end

    new_possible_words = @possible_words
    new_possible_words.each do |word|
      word.split("").each_with_index do |letter, i|
        if found_letters.keys.include?(i)
          new_possible_words.delete(word) unless found_letters[i] == letter
        end
      end
    end

    @possible_words = new_possible_words
  end

  def get_most_frequent_letter(board)
    found_letters = {}
    board.each_with_index do |letter, i|
      found_letters[i] = letter.to_s.downcase unless letter.nil?
    end

    frequencies = Hash.new(0)
    @possible_words.each do |word|
      word.split("").each_with_index do |letter, i|
        if found_letters.include?(i)
          frequencies[letter] += 1 unless found_letters(i) != letter
        else
          frequencies[letter] += 1
        end
      end
    end

    highest_frequency = frequencies.values.sort.last
    frequencies.key(highest_frequency)
  end
end

#Run as script
if __FILE__ == $PROGRAM_NAME
  game = Hangman.new
  game.play
end
