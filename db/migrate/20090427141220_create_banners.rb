class CreateBanners < ActiveRecord::Migration
  def self.up
    create_table :banners do |t|
      t.string :code, :null => false
      t.string :url, :null => false
      
      t.integer :clicks, :null => false, :default => 0
    end
    
    Banner.create(:code => 'corrupted', :url => 'http://www.recoverytoolbox.com/docx_recover.html')
  end

  def self.down
    drop_table :banners
  end
end
