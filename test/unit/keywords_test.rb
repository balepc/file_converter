require 'test_helper'

class KeywordsTest < Test::Unit::TestCase
  include KeywordsHelper
  
  context "get_frequences" do
    setup do
    end
    
    should "return keywords that occur more than 2 times" do
      assert_equal ['lazy'], get_frequences("quick lazy frog jumps over the lazy dog")
      assert_equal ['frog', 'lazy'], get_frequences("quick lazy frog jumps over the lazy frog")
    end
    
    should "not return keywords with lenght smaller than 3 symbols" do
      assert_equal [], get_frequences("do do do do")
    end
    
    should "return keywords sorted by frequency" do
      assert_equal ["dog", "fox"], get_frequences("fox fox dog dog fox dog dog")
    end
    
    should "return keywords sorted alphabetically" do
      assert_equal ["dog", "fox"], get_frequences("fox fox dog dog fox dog")
    end
  end
  
  context 'filename_keywords' do    
    should 'replace symbols' do
      assert_equal 'aaaa', filename_keywords('aa-aa')
      assert_equal 'aa aa', filename_keywords('aa.aa.aa')
    end
    
    should 'replace undelines' do
      assert_equal 'aa aa', filename_keywords('aa_aa')
    end
    
    should 'replace double undelines' do
      assert_equal 'aa a a', filename_keywords('aa__a___a')
    end
    
    should 'replace filextension' do
      assert_equal 'file', filename_keywords('file.docx')
      assert_equal 'file docx', filename_keywords('file.docx.docx')
    end
    
    should 'replace numbers' do
      assert_equal 'file', filename_keywords('file12')
      assert_equal 'file', filename_keywords('fi12le')
    end
    
    should 'work in common' do
      assert_equal 'Agreement Li Xue', filename_keywords('Agreement_Li_Xue__2_.docx')
      assert_equal 'Mehmet Yaranona teory', filename_keywords('Mehmet_Yaranona_teory.docx')
      assert_equal 'DEWS form March to', filename_keywords('DEWS_form_March_21_to_27_2009.d')
      assert_equal 'ИНСТИТУТ ЭКОНОМИ', filename_keywords('ИНСТИТУТ_ЭКОНОМИ')
      assert_equal 'SPRING SUMMER PROGRAMME', filename_keywords('SPRING___SUMMER_PROGRAMME_2009.')
      assert_equal 'RESUME', filename_keywords('RESUME.docx')
      assert_equal 'Music Man', filename_keywords('Music_Man_1-25-2009.docx')
      assert_equal 'Mănăstirea Argeşului Epi', filename_keywords('Mănăstirea__Argeşului_-__Epi')
    end
  end
  
end
