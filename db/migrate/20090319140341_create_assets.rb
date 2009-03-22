class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :asset_types do |t|
      t.string :name
      t.string :code
    end
    
    create_table :assets do |t|
      t.string :filename
      t.string :content_type
      
      t.string :size
      
      t.timestamps
    end
  end

  def self.down
    drop_table :asset_types
    drop_table :assets
  end
end
