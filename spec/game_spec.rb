require 'game'

describe Game do
  subject(:game) { Game.new(4) }

  it "has players" do
    expect(game.players.count).to eq(4)
  end

  it "has a deck" do
    expect(game.deck.count).to eq(52)
  end

  context "while playing a game" do

    describe "#deal" do
      it "deals cards to players" do
        game.deal(game.players[0], 2)
        expect(game.players[0].hand.cards.count).to eq(2)
      end
    end
  end
end
