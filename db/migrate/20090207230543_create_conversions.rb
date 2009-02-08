class CreateConversions < ActiveRecord::Migration
  def self.up
    create_table :conversions do |t|
      t.string :filename
      t.string :content_type
      
      t.string :from
      t.string :to
      
      t.timestamps
    end
  end

  def self.down
    drop_table :conversions
  end
end
