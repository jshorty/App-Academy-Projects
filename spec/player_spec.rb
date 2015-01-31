require 'player'
require 'hand'

describe Player do
  subject(:player) { Player.new(1000) }

  it "has a bankroll" do
    expect(player.bankroll).to be_a(Integer)
  end

  it "has a hand" do
    expect(player.hand).to be_a(Hand)
  end
end
