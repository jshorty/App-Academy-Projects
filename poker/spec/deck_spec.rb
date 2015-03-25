require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  it "stores its cards in array" do
    expect(deck.cards.class).to eq(Array)
    expect(deck.cards.sample.class).to eq(Card)
  end

  it "has one of each of the standard 52 cards" do
    expect(deck.cards.length).to eq(52)
    expect(deck.cards).to eq(deck.cards.uniq)
  end

  describe "#draw" do
    it "can draw cards from the deck" do
      expect(deck.draw(1)).to be_an(Array)
    end

    it "removes drawn cards from the deck" do
      initial_count = deck.cards.count
      deck.draw(1)
      expect(initial_count - deck.cards.count).to eq(1)
    end
  end

  describe "#generate_cards" do
    it "returns an array with 52 unique cards" do
      cards = deck.generate_cards
      expect(cards).to be_an(Array)
      expect([cards.length, cards.uniq.length]).to all(be == 52)
    end
  end

  describe "#return" do
    it "returns cards to the bottom of the deck" do
      cards = [:card1, :card2, :card3]
      deck.return(cards)
      expect(deck.cards).to include(:card1, :card2, :card3)
    end
  end

  describe "#shuffle_cards" do
    it "changes order of the cards" do
      original = deck.cards
      deck.shuffle
      shuffled = deck.cards

      expect(original).not_to eq(shuffled)
    end

    it "does not remove any cards" do
      expect(deck.cards.count).to eq(deck.shuffle.count)
    end
  end
end
