class ConversionsUpdate < ActiveRecord::Migration
  def self.up    
    remove_column :conversions, :filename
    remove_column :conversions, :content_type
    remove_column :conversions, :ip_address
    remove_column :conversions, :exception
    remove_column :conversions, :filesize
    
    add_column :conversions, :asset_from_id, :integer
    add_column :conversions, :asset_to_id, :integer
  end

  def self.down
  end
end
