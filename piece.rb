#encoding: UTF-8
require 'byebug'

class InvalidMoveError < StandardError
end

class Piece
  attr_reader :color, :board
  attr_accessor :position

  def initialize(color, king, position, board)
    @color = color
    @king = false
    @position = position
    @board = board
  end

  def display
    @king ? token = "✪" : token = "●"
    case color
    when :black then token = token.colorize(:black)
    when :red then token = token.colorize(:light_red)
    end
    token
  end

  def dup(board_copy)
    Piece.new(color, king, position, board_copy)
  end

  def perform_moves(moves)
    if valid_move_seq?(moves)
      perform_moves!(moves)
    else
      raise InvalidMoveError.new("Illegal move!")
    end
  end

  def perform_moves!(moves)
    if moves.length == 1
      unless perform_slide(moves[0]) || perform_jump(moves[0])
        raise InvalidMoveError.new("Illegal move!")
      end


    elsif moves.length > 1
      moves.each do |end_pos|
        unless perform_jump(end_pos)
          raise InvalidMoveError.new("Illegal move!")
        end
      end

    else
      raise InvalidMoveError.new("No movement!")
    end

    return true
  end

  def perform_slide(end_pos)
    return false unless valid_slide?(end_pos)
    move(end_pos)
    return true
  end

  def perform_jump(end_pos)
    return false unless valid_jump?(end_pos)
    jump_piece(end_pos)
    move(end_pos)
    return true
  end

  def valid_slide?(end_pos)
    return false unless board.empty?(end_pos)
    squares_away?(1, end_pos)
  end

  def valid_jump?(end_pos)
    jumped_square = find_jumped_square(end_pos)
    return false unless board.enemy?(jumped_square, color)
    return false unless board.empty?(end_pos)
    squares_away?(2, end_pos)
  end

  def move(end_pos)
    board[position] = nil
    self.position = end_pos
    board[end_pos] = self
    maybe_promote
  end

  def valid_move_seq?(moves)
    begin
      board.dup[position].perform_moves!(moves)
    rescue InvalidMoveError
      return false
    end
    return true
  end

  def maybe_promote
    case color
    when :red then @king == true if position[1] == 7
    when :black then @king == true if position[1] == 0
    end
  end

  def jumping?(end_pos)
    dx = end_pos[0] - position[0]
    return false unless dx.abs == 2
    return true
  end

  def find_jumped_square(end_pos)
    x1, y1 = position
    x2, y2 = end_pos
    dx = x2 - x1
    dy = y2 - y1
    [x1 + (dx / 2), y1 + (dy / 2)]
  end

  def jump_piece(end_pos)
    jumped_square = find_jumped_square(end_pos)
    board[jumped_square] = nil
  end

  def squares_away?(n, end_pos)
    x, y = position
    move_diffs.any? { |dx, dy| end_pos == [x + dx * n, y + dy * n] }
  end

  def move_diffs
    black =  [[1, -1], [-1, -1]]
    red = [[1,1], [-1, 1]]
    return black + red if @king
    return black if color == :black
    return red if color == :red
  end
end
