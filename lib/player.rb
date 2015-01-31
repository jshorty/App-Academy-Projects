require_relative 'hand'

class Player
  attr_accessor :bankroll, :hand, :name

  def initialize(name, bankroll)
    @name = name
    @bankroll = bankroll
    @hand = Hand.new
  end

  def discard
    display_hand

    card_nums = get_card_nums
    until card_nums == [] || card_nums.all? {|num| num.to_i.between?(1,5)}
      puts "Invalid card numbers! Try again."
      card_nums = get_card_nums
    end
    card_indices = card_nums.map {|num| num = num.to_i - 1}

    discarded_cards = []
    card_indices.each do |i|
      discarded_cards << hand.cards.delete_at(i)
    end
    discarded_cards
  end

  def display_hand
    puts
    puts "#{name.upcase}'S HAND:"
    puts hand.display
    puts "  1   2   3   4   5"
  end

  def get_card_nums
    puts "Enter card numbers one at a time to discard that card,"
    print "pressing enter again when finished to replace chosen cards: "
    input = []
    input << gets.chomp
    until input.last == ""
      print "Selected: #{input}"
      input << gets.chomp
    end
    input.pop
    input
  end

end
