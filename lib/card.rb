class Card
  attr_reader :name, :suit, :value

  def initialize(name, suit, value)
    @name = name
    @suit = suit
    @value = value
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
