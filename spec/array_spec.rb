require 'array'

describe Array do
  describe "#my_uniq" do
    let(:arr) { [6,4,1,3,6] }

    it "remove duplicates from an array" do
      expect([1,2,2,3].my_uniq).to eq([1,2,3])
    end

    it "returns unique elements in the order they appeared" do
      expect([4,4,1,2,6].my_uniq).to eq([4,1,2,6])
    end

    it "does not modify the original array" do
      expect(arr.my_uniq).to_not equal(arr)
    end
  end

  describe "#two_sum" do
    let(:arr) { [-1,4,1,-4,6] }

    it "returns all zero sum pairs of elements" do
      expect([2,-3,4,-4,3,6].two_sum).to include([2,3], [1,4])
    end

    it "sorts pairs dictionary-wise" do
      expect(arr.two_sum).to eq([[0,2],[1,3]])
    end
  end
end
