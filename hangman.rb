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
  end

  def setup
    create_new_players(intro_input)
    @word_length = player1.word_length
    @word_length.times {@board << nil}
    display_word_length
  end

  def create_new_players(mode)
    case mode
      when 1 then @player1 = HumanPlayer.new, ComputerPlayer.new
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
      print "Please select a valid game mode! (1-3)"
      input = gets.chomp
    end
    return input.to_i
  end

  def display_word_length
    puts "The secret word is #{word_length} letters long."
    puts render_board
  end

  def render_board
    rendered_board = []
    @board.each do |letter|
      if letter.nil?
        rendered_board << "_"
      else
        rendered_board << letter.to_s.upcase
      end
    end
    rendered_board.join(" ")
  end
end

class HumanPlayer
  def initialize
    @word_length = nil
  end

  def word_length
    print "Please choose a secret word and enter its length:"
    input = gets.chomp
    until (1..25).include?(input.to_i)
      print "Please enter a valid word length (1-25):"
    end
    @word_length = input.to_i
  end
end

class ComputerPlayer
  def initialize
    @word = nil
  end

  def word_length
    dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @word = dictionary.sample
    @word.length
  end
end

#Run as script
if __FILE__ == $PROGRAM_NAME
  game = Hangman.new
  game.play
end
