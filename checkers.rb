require_relative 'board'
require_relative 'piece'
require 'colorize'

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.set_starting_pieces
  b.render
end
