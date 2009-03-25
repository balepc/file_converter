require 'test_helper'

class KeywordsTest < Test::Unit::TestCase
  include KeywordsHelper
  
  context "get_keywords" do
    setup do
    end
    
    should "return keywords that occur more than 2 times" do
      assert_equal ['lazy'], get_keywords("quick lazy frog jumps over the lazy dog")
      assert_equal ['frog', 'lazy'], get_keywords("quick lazy frog jumps over the lazy frog")
    end
    
    should "not return keywords with lenght smaller than 3 symbols" do
      assert_equal [], get_keywords("do do do do")
    end
    
    should "return keywords sorted by frequency" do
      assert_equal ["dog", "fox"], get_keywords("fox fox dog dog fox dog dog")
    end
    
    should "return keywords sorted alphabetically" do
      assert_equal ["dog", "fox"], get_keywords("fox fox dog dog fox dog")
    end
    
  end
  
end
