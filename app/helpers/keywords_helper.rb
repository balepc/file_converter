module KeywordsHelper
  MIN_LENGHT = 3
  
  def get_keywords(full_text)  
    words = FrequencyHash.new
    full_text.split(/\W/).each do |word|
      words.occur(word) if word.length >= MIN_LENGHT
    end
    words.frequent_keys(2)
  end
  
end