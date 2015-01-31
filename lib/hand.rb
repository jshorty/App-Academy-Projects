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

  def full_house?
    pair? && three_of_a_kind?
  end

  def four_of_a_kind?
    card_counts.any? { |card, count| count == 4 }
  end

  def three_of_a_kind?
    card_counts.any? { |card, count| count == 3 }
  end

  def pair?
    card_counts.any? { |card, count| count == 2 }
  end

  def card_counts
    card_ranks = Hash.new(0)
    cards.each { |card| card_ranks[card.name] += 1 }
    card_ranks
  end

  def high_card(card_arr)
    cards.sort_by! { |card| card.value }
    cards.last.value
  end
end
