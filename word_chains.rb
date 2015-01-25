class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp)
  end

  def adjacent_words(word)
    same_length_words = @dictionary.select { |dict_word|
                        dict_word.length == word.length }
    same_length_words.delete(word)
    adjacent_words = []
    same_length_words.each do |new_word|
      different_letters = 0
      new_word.split("").each_with_index do |letter, i|
        different_letters += 1 if letter != word[i]
      end
      adjacent_words << new_word if different_letters == 1
    end

    adjacent_words
  end
end
