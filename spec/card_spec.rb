require 'card'

describe Card do
  subject(:card) { Card.new(:king, :hearts, 13) }

  it "has a name, suit, and poker value" do
    expect(card.name).to eq(:king)
    expect(card.suit).to eq(:hearts)
    expect(card.value).to eq(13)
  end
end
