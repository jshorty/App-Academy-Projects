class Piece
  attr_reader :color
  attr_accessor :position

  def initialize(color, king, position, board)
    @color = color
    @king = false
    @position = position
  end

  def move_diffs
    [1, 1, -1, -1].permutation(2).to_a.uniq
  end

  def perform_slide(end_pos)
    if position
  end

  def perform_jump(end_pos)
  end

  def maybe_promote
    @king = true if position == #BACK ROW
  end
end
