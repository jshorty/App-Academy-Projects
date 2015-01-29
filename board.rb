class Board
  attr_reader :squares

  def initialize()
    @squares = Array.new(8) { Array.new(8) }
  end

  def [](pos)
    squares[pos[1]][pos[0]]
  end

  def []=(pos, value)
    squares[pos[1]][pos[0]] = value
  end

  def set_starting_pieces
    self[[0,0]] = Piece.new(:red, false, [0,0], self)
    self[[2,0]] = Piece.new(:red, false, [2,0], self)
    self[[4,0]] = Piece.new(:red, false, [4,0], self)
    self[[6,0]] = Piece.new(:red, false, [6,0], self)
    self[[1,1]] = Piece.new(:red, false, [1,1], self)
    self[[3,1]] = Piece.new(:red, false, [3,1], self)
    self[[5,1]] = Piece.new(:red, false, [5,1], self)
    self[[7,1]] = Piece.new(:red, false, [7,1], self)
    self[[0,2]] = Piece.new(:red, false, [0,2], self)
    self[[2,2]] = Piece.new(:red, false, [2,2], self)
    self[[4,2]] = Piece.new(:red, false, [4,2], self)
    self[[6,2]] = Piece.new(:red, false, [6,2], self)

    self[[1,5]] = Piece.new(:black, false, [1,5], self)
    self[[3,5]] = Piece.new(:black, false, [3,5], self)
    self[[5,5]] = Piece.new(:black, false, [5,5], self)
    self[[7,5]] = Piece.new(:black, false, [7,5], self)
    self[[0,6]] = Piece.new(:black, false, [0,6], self)
    self[[2,6]] = Piece.new(:black, false, [2,6], self)
    self[[4,6]] = Piece.new(:black, false, [4,6], self)
    self[[6,6]] = Piece.new(:black, false, [6,6], self)
    self[[1,7]] = Piece.new(:black, false, [1,7], self)
    self[[3,7]] = Piece.new(:black, false, [3,7], self)
    self[[5,7]] = Piece.new(:black, false, [5,7], self)
    self[[7,7]] = Piece.new(:black, false, [7,7], self)
  end

  def occupied?(pos)
    self[pos].is_a? Piece
  end

  def enemy?(pos, color)
    occupied?(pos) && self[pos].color != color
  end

  def empty?(pos)
    !occupied?(pos)
  end

  def remove_piece(pos)
    self[pos] = nil
  end

  def render
    colored = true
    squares.each do |row|
      row.each do |square|
        piece = "   " if square.nil?
        piece = " #{square.display} " if square
        if colored
          print piece.colorize(:background => :red)
          colored = false
        else
          print piece.colorize(:background => :light_white)
          colored = true
        end
      end
      print "\n"
      colored = !colored
    end
    return
  end
end
