require 'colorize'

class Card
  attr_reader :name, :suit, :value

  def initialize(name, suit)
    @name = name
    @suit = suit
    @value = VALUES[name]
  end

  def inspect
    print display
  end

  def display
    case value
    when 11 then char = "J"
    when 12 then char = "Q"
    when 13 then char = "K"
    when 14 then char = "A"
    else
      char = value.to_s
    end

    case suit
    when :spades then symbol = "[♠#{char}]".colorize(:black)
    when :clubs then symbol = "[♣#{char}]".colorize(:black)
    when :hearts then symbol = "[♥#{char}]".colorize(:red)
    when :diamonds then symbol = "[♦#{char}]".colorize(:red)
    end

    symbol
  end

  SUITS = [:spades, :hearts, :diamonds, :clubs]

  VALUES = {
    ace: 14,
    king: 13,
    queen: 12,
    jack: 11,
    ten: 10,
    nine: 9,
    eight: 8,
    seven: 7,
    six: 6,
    five: 5,
    four: 4,
    three: 3,
    two: 2,
  }
end
