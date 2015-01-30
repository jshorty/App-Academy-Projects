class Hanoi

  attr_accessor :rows,:row1, :row2, :row3

  def initialize
    @rows = [[3, 2, 1], [], []]
    @row1 = rows[0]
    @row2 = rows[1]
    @row3 = rows[2]
  end

  def won?
    row1.empty? && (row2.empty? || row3.empty?)
  end

  def move(start_row, end_row)
    end_row.push(start_row.pop) if valid_move?(start_row, end_row)
    rows = [row1, row2, row3]
  end

  def valid_move?(start_row, end_row)
    return false if start_row.empty?

    unless end_row.empty?
      return false if start_row.last > end_row.last
    end

    true
  end

end
