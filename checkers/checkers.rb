require_relative 'board'
require_relative 'piece'
require_relative 'player'
require_relative 'game'
require 'colorize'

if __FILE__ == $PROGRAM_NAME
  puts "Checkers by Jake Shorty 2015"
  Game.new.play
end
