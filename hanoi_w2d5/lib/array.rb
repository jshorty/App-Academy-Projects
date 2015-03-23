class Array

  def my_uniq
    each_with_object([]) do |el, new_array|
      new_array << el unless new_array.include?(el)
    end
  end

  def two_sum
    two_sums = []

    each_with_index do |el, idx|
      (idx..self.length - 1).each do |j|
        two_sums << [idx, j] if el + self[j] == 0
      end
    end

    two_sums
  end
end
