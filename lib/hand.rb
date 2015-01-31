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

  def find_matches(num)
    match = card_counts.key(num)
    matches = cards.select { |card| card.name == match }
    [matches, cards - matches]
  end

  def four_of_a_kind?
    card_counts.any? { |card, count| count == 4 }
  end

  def three_of_a_kind?
    card_counts.any? { |card, count| count == 3 }
  end

  def two_pair?
    pairs = card_counts.keys.find_all { |card| card_counts[card] == 2}
    pairs.count == 2
  end

  def pair?
    card_counts.any? { |card, count| count == 2 }
  end

  def card_counts
    card_ranks = Hash.new(0)
    cards.each { |card| card_ranks[card.name] += 1 }
    card_ranks
  end

  def high_card(some_cards)
    some_cards.sort_by! { |card| card.value }
    some_cards.last.value
  end

  def optimize_hand
    optimal_hand = {rank: 1, ranked: cards, other: []}
    if straight? && flush?
      optimal_hand[:rank] = 9
    elsif four_of_a_kind?
      optimal_hand[:rank] = 8
      optimal_hand[:ranked] = find_matches(4)[0]
      optimal_hand[:other] = find_matches(4)[1]
    elsif full_house?
      optimal_hand[:rank] = 7
    elsif flush?
      optimal_hand[:rank] = 6
    elsif straight?
      optimal_hand[:rank] = 5
    elsif three_of_a_kind?
      optimal_hand[:rank] = 4
      optimal_hand[:ranked] = find_matches(3)[0]
      optimal_hand[:other] = find_matches(3)[1]
    elsif two_pair?
      optimal_hand[:rank] = 3
      cards.sort_by! { |card| cards.count(card) }
      optimal_hand[:ranked] = cards.drop(1)
      optimal_hand[:other] = cards.take(1)
    elsif pair?
      optimal_hand[:rank] = 2
      optimal_hand[:ranked] = find_matches(2)[0]
      optimal_hand[:other] = find_matches(2)[1]
    end
    optimal_hand
  end
end
