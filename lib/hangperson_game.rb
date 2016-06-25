class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess letter
    raise ArgumentError if letter.nil? || letter.empty?
    raise ArgumentError unless letter =~ /^[a-z]$/i
    
    small_letter = letter.downcase
    
    return false if guesses.include? small_letter
    return false if wrong_guesses.include? small_letter
    
    if word.include? small_letter
      guesses << small_letter
    else
      wrong_guesses << small_letter
    end
    true
  end
  
  def word_with_guesses
    word.split('').map do |letter|
      if guesses.include? letter
        letter
      else
        '-'
      end
    end.join
  end
  
  def check_win_or_lose
    return :win if !word_with_guesses.include? '-'
    return :lose if wrong_guesses.length >= 7
    
    :play
  end
    

end
