require_relative 'player'
require_relative 'deck'

class Game
  attr_reader :players, :deck, :pot

  def initialize(players)
    @players = []
    players.times { |i| @players << Player.new( "Player#{i+1}", 100) }
    @deck = Deck.new
    @pot = 0
  end

  def deal(player, num_cards)
    player.hand.hold(deck.draw(num_cards))
  end

  def hand_of_poker
    players_in_hand = players.dup

    #deal out 5 cards to each player
    players.each {|player| deal(player, 5)}

    #first round of betting
    remaining_players = betting_round(players_in_hand)

    #ask each player to discard up to 5 cards, replace up to 5 cards
    exchange_cards

    #second round of betting
    betting_round(remaining_players)

    #compare_cards
  end

  # !! does not account for players who are all in !!
  def betting_round(players_in_hand)
    players_in_hand.each { |player| player.called = false }
    current_bet = 0

    #loops through players until betting is resolved
    until players_in_hand.all? { |player| player.called? }
      bettor = players_in_hand.shift
      bet = bettor.get_bet(current_bet - bettor.already_bet)
      case bet
      when :fold
        puts "#{bettor.name} folds."
      when :call
        @pot += current_bet - (bettor.already_bet - current_bet)
        puts "#{bettor.name} calls (#{current_bet})."
        bettor.called = true
        players_in_hand << bettor
      else
        puts "#{bettor.name} raises to #{bet}!"
        @pot += bet
        current_bet = bet
        players_in_hand.each { |player| player.called = false }
        bettor.called = true
        players_in_hand << bettor
      end
    end

    players.each { |player| player.already_bet = 0 }
    players_in_hand
  end

  def exchange_cards
    players.each do |player|
      discarded_cards = player.discard
      deck.return(discarded_cards)
      deal(player, discarded_cards.count)
    end
  end
end
