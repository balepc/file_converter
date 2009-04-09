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
  
  def filename_keywords(filename)
    # remove extension
    filename.gsub!(/#{File.extname(filename)}$/, '') 
    
    # remove numbers
    filename.gsub!(/[0-9]/, '')
           
    # replace symbols
    ['-', '$'].each do |sym|
      filename.gsub!(sym, '')
    end
    
    # remove double underline
    filename.gsub!('__', '_')
    
    # replace underline with whitespaces
    filename.gsub!('_', ' ')
    filename.gsub!('.', ' ')
    filename.gsub!('  ', ' ')
    filename.strip
  end
  
end