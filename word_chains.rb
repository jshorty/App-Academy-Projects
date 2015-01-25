require 'set'

class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }

    until @current_words.empty?
      new_current_words = explore_current_words
      @current_words = new_current_words
      break if @current_words.include?(target)
    end

    if @all_seen_words.include?(target)
      build_path(target)
    else
      puts "No path between the two words was found in this dictionary."
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

  def explore_current_words
    new_current_words = []
    @current_words.each do |word|
      adjacent_words(word).each do |new_word|
        next if @all_seen_words.include?(new_word)
        new_current_words << new_word
        @all_seen_words[new_word] = word
      end
    end
    #new_current_words.each do |new_word|
    #  puts "#{@all_seen_words[new_word]} => #{new_word}"
    #end
    new_current_words
  end

  def build_path(target)
    path = [target]
    until path.last.nil?
      path << @all_seen_words[path.last]
    end
    path.reverse.drop(1)
  end
end
