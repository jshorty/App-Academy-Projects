require_relative 'player'
require_relative 'deck'

class Game
  attr_reader :players, :deck

  def initialize(players)
    @players = []
    players.times { @players << Player.new(100) }
    @deck = Deck.new
  end

  def deal(player, num_cards)
    player.hand.hold(deck.draw(num_cards))
  end


end
