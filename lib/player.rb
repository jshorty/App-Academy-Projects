class Player
  attr_accessor :bankroll, :hand

  def initialize(bankroll)
    @bankroll = bankroll
    @hand = Hand.new
  end

end
