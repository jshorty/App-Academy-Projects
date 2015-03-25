class Board
  attr_reader :squares

  def initialize(place_pieces)
    @squares = Array.new(8) { Array.new(8) }
    set_starting_pieces if place_pieces
  end

  def [](pos)
    squares[pos[1]][pos[0]]
  end

  def []=(pos, value)
    squares[pos[1]][pos[0]] = value
  end

  def dup
    copy = Board.new(false)
    self.squares.each do |row|
      row.each do |square|
        copy[square.position] = square.dup(copy) if square.is_a? Piece
      end
    end
    return copy
  end

  def set_starting_pieces
    black_rows = [5, 6, 7]
    red_rows = [0, 1, 2]
    fill_rows(black_rows, :black, false)
    fill_rows(red_rows, :red, true)
  end

  def fill_rows(rows, color, even)
    rows.each do |y|
      even ? row_squares = [0, 2, 4, 6] : row_squares = [1, 3, 5, 7]
      row_squares.each do |x|
        self[[x,y]] = Piece.new(color, false, [x, y], self)
      end
      even = !even
    end
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

  def lost?(color)
    squares.each do |row|
      row.each do |square|
        if square.is_a? Piece
          return false if square.color == color
        end
      end
    end
    return true
  end

  def over?
    lost?(:black) || lost?(:red)
  end

  def remove_piece(pos)
    self[pos] = nil
  end

  def display
    colored = true
    row_number = 8

    puts "                              ".colorize(:background => :light_white)
    squares.each do |row|
      print " #{row_number} ".colorize(:background => :light_white)
      row_number -= 1
      row.each do |square|
        piece = "   " if square.nil?
        piece = " #{square.display} " if square
        if colored
          print piece.colorize(:background => :red)
          colored = false
        else
          print piece.colorize(:background => :light_black)
          colored = true
        end
      end
      print "   ".colorize(:background => :light_white)
      print "\n"
      colored = !colored
    end
    puts "    A  B  C  D  E  F  G  H    ".colorize(:background => :light_white)
    return
  end

  def inspect
    display
  end
end
