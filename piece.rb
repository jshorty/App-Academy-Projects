#encoding: UTF-8
require 'byebug'
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
    @king ? token == "✪" : token == "●"
    case color
    when :black then token = token.colorize(:black)
    when :red then token = token.colorize(:light_red)
    end
    token
  end

  def perform_slide(end_pos)
    return false unless valid_move?(end_pos)
    move(end_pos)
    return true
  end

  def perform_jump(end_pos)
    return false unless valid_move?(end_pos)
    jump_piece(end_pos)
    move(end_pos)
    return true
  end

  def move(end_pos)
    board[position] = nil
    self.position = end_pos
    board[end_pos] = self
    maybe_promote
  end

  def valid_move?(end_pos)
    return false unless in_range?(end_pos) && board.empty?(end_pos)
    if jumping?(end_pos)
      jumped_square = find_jumped_square(end_pos)
      return false unless board.enemy?(jumped_square, color)
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
    debugger
    board[jumped_square] = nil
  end

  def in_range?(end_pos)
    x, y = position
    move_diffs.any? { |dx, dy| end_pos == [x + dx, y + dy] }
  end

  def move_diffs
    red = [[1,1], [-1, 1], [2, 2], [-2, 2]]
    black =  [[1, -1], [-1, -1], [2, -2], [-2, -2]]
    return red + black if @king
    return black if color == :black
    return red if color == :red
  end
end
