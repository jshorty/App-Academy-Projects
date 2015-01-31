require_relative 'player'
require_relative 'deck'

class Game
  attr_reader :players, :deck

  def initialize(players)
    @players = []
    players.times { |i| @players << Player.new( "Player#{i+1}", 100) }
    @deck = Deck.new
  end

  def deal(player, num_cards)
    player.hand.hold(deck.draw(num_cards))
  end

  def hand_of_poker
    #deal out 5 cards to each player
    players.each {|player| deal(player, 5)}

    #ask each player to discard up to 5 cards, replace up to 5 cards
    exchange_cards
  end

  def exchange_cards
    players.each do |player|
      discarded_cards = player.discard
      deck.return(discarded_cards)
      deal(player, discarded_cards.count)
    end
  end
end
