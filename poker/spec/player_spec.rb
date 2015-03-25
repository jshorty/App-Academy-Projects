require 'player'
require 'hand'

describe Player do
  subject(:player) { Player.new("Michael", 100) }

  it "has a name" do
    expect(player.name).to eq("Michael")
  end

  it "has a bankroll" do
    expect(player.bankroll).to eq(100)
  end

  it "has a hand" do
    expect(player.hand).to be_a(Hand)
  end

  it "keeps track of bet amount in current hand" do
    expect(player.already_bet).to be_a(Fixnum)
  end

  it "knows if it has called the current bet" do
    expect(player.called?).to eq(false)
  end
end
