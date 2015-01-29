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
    puts "Double jumps are currently handled one step at a time."
    board.display
  end

  def winner(color)
    puts "#{color.to_s.capitalize} wins! Congratulations."
  end

  def turn(player)
    begin
      move = player.get_move
      piece = board[move[0]]
      unless piece.is_a? Piece && piece.color == player.color
        raise InvalidMoveError("Not your piece!")
      end
      piece.perform_moves([move[1]])
      # unless piece.possible_jumps.empty?
      #     puts "That piece can keep going! :)"
      #     move = play.get_move

    rescue InvalidMoveError => msg
      puts msg
      retry
    end
    board.display
    debugger
  end
end
