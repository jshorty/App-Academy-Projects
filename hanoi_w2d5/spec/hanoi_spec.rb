require 'hanoi'

describe Hanoi do
  subject(:hanoi) { Hanoi.new }

  it "can call rows individually" do
    expect(hanoi.row1).to eq(hanoi.rows[0])
    expect(hanoi.row2).to eq(hanoi.rows[1])
    expect(hanoi.row3).to eq(hanoi.rows[2])
  end

  describe "#row" do
    it "starts with 3 rows" do
      expect(hanoi.rows.count).to eq(3)
    end

    it "disks start in first row" do
      expect(hanoi.row1).not_to be_empty
      expect([hanoi.row2, hanoi.row3]).to all(be_empty)
    end

    it "starts with more than one disk" do
      expect(hanoi.rows[0].count > 1).to eq(true)
    end

    it "first stack is reverse sorted" do
      expect(hanoi.rows[0]).to eq(hanoi.rows[0].sort.reverse)
    end
  end

  describe "#move" do
    it "moves a disc from end of first row to end of next row" do
      hanoi.move(hanoi.row1, hanoi.row2)
      expect(hanoi.row1).to eq([3,2])
      expect(hanoi.row2).to eq([1])
    end
  end

  describe "#valid_move?" do
    it "returns true on a valid move" do
      expect(hanoi.valid_move?([3,2,1],[])).to eq(true)
    end

    it "returns false when 'to' row's top disc is too small" do
      expect(hanoi.valid_move?([3,2],[1])).to eq(false)
    end

    it "returns false on an empty 'from' row" do
      expect(hanoi.valid_move?([],[3,2])).to eq(false)
    end
  end

  describe "#won?" do
    it "return true on a winning board" do
      hanoi_won = Hanoi.new
      hanoi_won.row1, hanoi_won.row2 = [], []
      hanoi_won.row3 = [3,2,1]
      expect(hanoi_won).to be_won
    end

    it "returns false on a board that isn't won" do
      hanoi_lose = Hanoi.new
      hanoi_lose.rows = [[] , [1], [3,2]]
      expect(hanoi_lose).not_to be_won
    end
  end

  # describe "#get_user_input" do
  #   let(:input) { hanoi.get_user_input }
  #   it "returns an array of two unique numbers between 1-3" do
  #     input =
  #     expect(input.length).to eq(2)
  #     expect(input.each).to all(be_between(1,3))
  #   end
  # end
end
