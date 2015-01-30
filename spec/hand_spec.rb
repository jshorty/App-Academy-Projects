require 'hand'
require 'card'

describe Hand do
  subject(:hand) { Hand.new }
  let(:ace_s) { Card.new(:ace, :spades, 14) }
  let(:king_s) { Card.new(:king, :spades, 13) }
  let(:queen_s) { Card.new(:queen, :spades, 12) }
  let(:jack_s) { Card.new(:jack, :spades, 11) }
  let(:jack_h) { Card.new(:jack, :hearts, 11) }
  let(:ten_s) { Card.new(:ten, :spades, 10) }
  let(:ten_h) { Card.new(:ten, :hearts, 10) }
  let(:ten_d) { Card.new(:ten, :diamonds, 10) }
  let(:ten_c) { Card.new(:ten, :clubs, 10) }

  describe "#hold" do
    it "takes and holds cards" do
      hand.hold([ace_s, king_s])

      expect(hand.cards).to eq([ace_s, king_s])
      expect(hand.cards).to be_an(Array)
    end
  end

  describe "#flush?" do
    it "detects a flush" do
      hand.cards = [ace_s, king_s, queen_s, jack_s, ten_s]
      expect(hand.flush?).to eq(true)
    end

    it "rejects cards that aren't a flush" do
      hand.cards = [ace_s, king_s, queen_s, jack_s, ten_h]
      expect(hand.flush?).to eq(false)
    end
  end

  describe "#straight?" do
    it "detects a straight" do
      hand.cards = [ace_s, king_s, queen_s, jack_s, ten_s]
      expect(hand.straight?).to eq(true)
    end

    it "rejects cards that aran't a straight" do
      hand.cards = [ace_s, king_s, queen_s, jack_s, jack_h]
      expect(hand.straight?).to eq(false)
    end
  end



  # describe "#flush?" do
  #   it "hand can " do
  #
  #   end
  # end

end
