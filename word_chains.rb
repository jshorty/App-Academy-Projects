require 'set'

class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = [source]

    until @current_words.empty?
      new_current_words = []

      @current_words.each do |word|
        adjacent_words(word).each do |new_word|
          next if @all_seen_words.include?(new_word)
          new_current_words << new_word
          @all_seen_words << new_word
        end
      end

      @current_words = new_current_words
      puts "NEW CURRENT WORDS:"
      puts @current_words
    end
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
