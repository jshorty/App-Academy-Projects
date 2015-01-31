require 'byebug'
require_relative 'hand'

class IllegalBetError < StandardError
end

class Player
  attr_accessor :bankroll, :hand, :name, :already_bet
  attr_writer :called

  def initialize(name, bankroll)
    @name = name
    @bankroll = bankroll
    @hand = Hand.new
    @already_bet = 0
    @called = false
  end

  def display_hand
    puts
    puts "#{name.upcase}'S HAND:"
    puts hand.display
  end

  def get_bet(current_bet)
    begin
      puts
      puts "#{name.capitalize}, you must bet #{current_bet} to call."
      puts "You have #{bankroll} to bet with."
      display_hand
      print "Enter 'f' to fold, 'c' to call, or an amount to raise: "
      input = gets.chomp.downcase
      until input.to_i > 0 || ["f", "c"].include?(input)
        print "Invalid input. Enter 'f', 'c', or raise amount: "
        input = gets.chomp.downcase
      end
      puts
      case input
      when "f" then return :fold
      when "c"
        raise IllegalBetError.new unless current_bet < bankroll
        debugger
        @already_bet += current_bet
        @bankroll -= current_bet
        return :call
      else
        input = input.to_i
        unless current_bet + input < bankroll
          raise IllegalBetError.new
        end
        @already_bet += current_bet + input
        @bankroll -= current_bet + input
        return current_bet + input
      end
    rescue IllegalBetError
      retry
    end
  end

  def called?
    @called
  end

  def discard
    display_hand
    puts "  1   2   3   4   5"

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
