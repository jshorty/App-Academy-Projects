require 'byebug'

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
      turn(@black)
      break if board.lost?(:red)
      turn(@red)
    end
    board.lost?(:red) ? winner(:red) : winner(:black)
  end

  def welcome
    puts
    puts "WELCOME TO CHECKERS!"
    board.display
  end

  def winner(color)
    puts "#{color.to_s.capitalize} wins! Congratulations."
  end

  def turn(player)
    begin
      move = @black.get_move
      debugger
      board[move[0]].perform_moves([move[1]]) #CAN ONLY HANDLE ONE MOVE!!!!!
    rescue InvalidMoveError => msg
      puts msg
      retry
    end
    board.display
  end
end
