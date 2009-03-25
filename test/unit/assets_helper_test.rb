require 'test_helper'

class AssetsHelperTest < Test::Unit::TestCase
  include AssetsHelper
  
  context "format_long_filenames" do
    
    should "should leave file extension" do
      assert_equal "wednesday_creative_n_...w.docx", format_long_filenames("wednesday_creative_n_media_cw.docx", 30)
      assert_equal "wednesday_creative_n_media_cw.docx", format_long_filenames("wednesday_creative_n_media_cw.docx", 40)
    end
    
  end
  
end
