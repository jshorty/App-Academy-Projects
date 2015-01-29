#encoding: UTF-8

class Piece
  attr_reader :color, :board
  attr_accessor :position

  def initialize(color, king, position, board)
    @color = color
    @king = false
    @position = position
  end

  def display
    if @king
      "K"
    else
      "P"
    end
  end

  def perform_slide(end_pos)
    if in_slide_range?(end_pos)
      position = end_pos
      board[[position]] = nil
      board[[end_pos]] = self
      return true
    end
    return false
  end

  def perform_jump(end_pos)
    if in_range?(end_pos)
      position = end_pos
      board.jump_piece(jumped_pos)
      board[[position]] = nil
      board[[end_pos]] = self
      return true
    end
    return false
  end

  #def maybe_promote
  #  @king = true if position == nil
  #end

  def in_range?(end_pos)
    x, y = position
    move_diffs.any? do |dx, dy|
      end_pos == [x + dx, y + dy]
    end
  end

  def move_diffs
    red = [[1,1], [-1, 1], [2, -2], [-2, -2]]
    black =  [[1, -1], [-1, -1], [2, 2], [-2, 2]]
    return red + black if @king
    return black if color == black
    return red if color == red
  end
end
