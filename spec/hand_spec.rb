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

  describe "#card_counts" do
    it "returns a hash with number of each card value in hand" do
      hand.cards = [ace_s, king_s, queen_s, jack_s, jack_h]
      expect(hand.card_counts).to eq({:ace => 1, :king => 1,
                                      :queen => 1, :jack => 2})
    end
  end

  describe "#flush?" do
    it "detects a flush" do
      hand.cards = [ace_s, king_s, queen_s, jack_s, ten_s]
      expect(hand.flush?).to eq(true)
    end

    it "rejects hands that aren't a flush" do
      hand.cards = [ace_s, king_s, queen_s, jack_s, ten_h]
      expect(hand.flush?).to eq(false)
    end
  end

  describe "#straight?" do
    it "detects a straight" do
      hand.cards = [ace_s, king_s, queen_s, jack_s, ten_s]
      expect(hand.straight?).to eq(true)
    end

    it "rejects hands that aren't a straight" do
      hand.cards = [ace_s, king_s, queen_s, jack_s, jack_h]
      expect(hand.straight?).to eq(false)
    end
  end

  describe "#four_of_a_kind?" do
    it "detects four of a kind" do
      hand.cards = [ten_s, ten_h, ten_d, ten_c, jack_s]
      expect(hand.four_of_a_kind?).to eq(true)
    end

    it "rejects hands that aren't four of a kind" do
      hand.cards = [queen_s, ten_h, ten_d, ten_c, jack_s]
      expect(hand.four_of_a_kind?).to eq(false)
    end
  end

  describe "#three_of_a_kind?" do
    it "detects three of a kind" do
      hand.cards = [ten_s, ten_h, ten_d, ace_s, jack_s]
      expect(hand.three_of_a_kind?).to eq(true)
    end

    it "rejects hands that aren't three of a kind" do
      hand.cards = [queen_s, ten_h, ten_d, ace_s, jack_s]
      expect(hand.three_of_a_kind?).to eq(false)
    end
  end

  describe "#pair?" do
    it "detects pairs" do
      hand.cards = [king_s, ten_h, ten_d, ace_s, jack_s]
      expect(hand.pair?).to eq(true)
    end

    it "rejects hands that don't have a pair" do
      hand.cards = [queen_s, ten_h, king_s, ace_s, jack_s]
      expect(hand.pair?).to eq(false)
    end
  end

  describe "#full_house?" do
    it "detects a full house" do
      hand.cards = [jack_h, ten_h, ten_d, ten_s, jack_s]
      expect(hand.full_house?).to eq(true)
    end

    it "rejects hands that aren't a full house" do
      hand.cards = [jack_h, ten_h, ten_d, ten_s, queen_s]
      expect(hand.full_house?).to eq(false)
    end
  end

  describe "#high_card" do
    it "finds highest card value from a set of cards" do
      hand.cards = [jack_h, ten_h, ten_d, ten_s, queen_s]
      expect(hand.high_card(hand.cards)).to eq(12)
    end
  end

  describe "#optimize_hand" do
    it "detects the best hand a player has"
    it "returns "
  end
end
