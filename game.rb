class Game
  attr_reader :board

  def initialize
    @board = Board.new(true)
    @black = Player.new(:black)
    @red = Player.new(:red)
  end

  def play
    welcome
    until board.over?
      move = @black.get_move
      board.display
      break if board.lost?(:red)
      move = @red.get_move
      board.display
    end
    board.lost?(:red) ? winner(:red) : winner(:black)
  end

  def welcome
    puts
    puts "WELCOME TO CHECKERS!"
    board.display
  end

  def winner(color)
    puts "#{color.to_s.upcase} wins! Congratulations."
  end
end
