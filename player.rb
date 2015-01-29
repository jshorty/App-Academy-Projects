class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_move
    puts "It is #{@color.capitalize}'s turn to move. "
    print "Please select a piece: "
    from = get_valid_input
    print "Please select where to move: "
    to = get_valid_input
    [to_coord(from), to_coord(to)]
  end

  def get_valid_input
    input = gets.chomp.downcase
    while input.scan(/\A[a-h]\d\z/).empty?
      print "Please enter a valid coordinate pair (A-H)(1-8): "
      input = gets.chomp.downcase
    end
    input
  end

  def to_coord(str) #Converts Player notation to coordinates in Board class
    abc = ("a".."h").to_a
    coords = str.split("")
    x = abc.index(coords[0].downcase)
    y = 8 - coords[1].to_i
    [x, y]
  end

end

# print "Please select a piece (A-H)(1-8) : " if to_or_from == :to
# input_str = gets.chomp.downcase
# #Validates proper input format
# while input_str.scan(/\A[a-h]\d\z/).empty?
#   print "Please enter valid coordinates (A-H)(1-8) :"
#   input_str = gets.chomp.downcase
# end
# input_str
