class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def hold(cards)
    @cards.concat(cards)
  end

  def flush?
    suit = cards.first.suit

    cards.all? { |card| card.suit == suit}
  end

  def straight?
    values = []
    cards.each { |card| values << card.value }
    values.sort!
    (values.count - 1).times do |i|
      return false unless values[i + 1] - values[i] == 1
    end
    return true
  end
end
