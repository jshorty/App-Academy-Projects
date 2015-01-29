require 'byebug'
class InvalidMoveError < StandardError
end

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
    print "\n\n"
    puts "     WELCOME TO CHECKERS!"
    board.display
  end

  def winner(color)
    puts "#{color.to_s.capitalize} wins! Congratulations."
  end

  def validate_piece(piece, player)
    unless (piece.is_a? Piece) && piece.color == player.color
      raise InvalidMoveError.new("Not your piece!")
    end
  end

  def turn(player)
    begin
      move = player.get_move
      piece = board[move[0]]
      validate_piece(piece, player)
      piece.perform_moves([move[1]])
    rescue InvalidMoveError => msg
      puts msg
      retry
    end
    board.display
  end
end
