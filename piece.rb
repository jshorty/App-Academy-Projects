class Piece
  def initialize(color, king)
    @color = color
    @king = false
  end

  def promote
    @king = true
  end
end
