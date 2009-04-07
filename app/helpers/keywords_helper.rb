require 'stemmer'
require 'whatlanguage'

module KeywordsHelper
  MIN_LENGHT = 3
  
  def get_frequences(full_text)  
    words = FrequencyHash.new
    full_text.split(/\W/).each do |word|
      word = word.stem
      words.occur(word) if word.length >= MIN_LENGHT
    end
    words.frequent_keys(2)
  end
  
end