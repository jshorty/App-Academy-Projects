require_relative 'card'

class Deck

  attr_accessor :cards

  def initialize
    @cards = generate_cards
  end

  def draw(num)
    drawn_cards = []
    num.times { drawn_cards << cards.shift }
    drawn_cards
  end

  def return(cards)
    self.cards.concat(cards)
  end

  def shuffle
    self.cards = cards.shuffle
  end

  def generate_cards
    array_o_cards = []

    Card::SUITS.each do |suit|
      Card::VALUES.each do |name, value|
        array_o_cards << Card.new(name, suit, value)
      end
    end

    array_o_cards
  end
end
