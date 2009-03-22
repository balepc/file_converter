class ScanAssetsContent < ActiveRecord::Migration
  def self.up
    add_column :assets, :content_full_text, :text
    add_column :assets, :content_keywords, :string, :limit => 1000
  end

  def self.down
  end
end
