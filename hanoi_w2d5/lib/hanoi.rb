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

  def get_user_input
    puts "What row you wanna move from?!"
    row_from = gets.chomp
    until row_from.length == 1 && row_from.to_i.between?(1,3)
      puts "Invalid input! (1-3)"
      row_from = gets.chomp
    end

    puts "What row you wanna move to?!"
    row_to = gets.chomp
    until row_to.length == 1 && row_to.to_i.between?(1,3) && row_to != row_from
      puts "Invalid input! (1-3)"
      row_to = gets.chomp
    end

    [row_to.to_i, row_from.to_i]
  end

  def play
    until won?
      puts @rows
      move(@rows[get_user_input[0]-1], @rows[get_user_input[1]-1])
    end
  end
end
