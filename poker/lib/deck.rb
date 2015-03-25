require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize
    @cards = generate_cards
    shuffle
  end

  def draw(num)
    drawn_cards = []
    num.times { drawn_cards << cards.shift }
    drawn_cards
  end

  def count
    return cards.count
  end

  def return(cards)
    self.cards.concat(cards)
  end

  def shuffle
    self.cards = cards.shuffle
  end

  def generate_cards
    cards = []

    Card::SUITS.each do |suit|
      Card::VALUES.each do |name, value|
        cards << Card.new(name, suit)
      end
    end

    cards
  end
end
