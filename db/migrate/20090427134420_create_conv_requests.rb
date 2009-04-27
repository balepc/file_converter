class CreateConvRequests < ActiveRecord::Migration
  def self.up
    create_table :conv_requests do |t|
      t.string :email, :null => false
      t.string :language
      t.string :encoding
      t.text   :description
      t.integer :user_id
      t.integer :asset_id
      
      t.boolean :important
      
      t.timestamps
    end
  end

  def self.down
    drop_table :conv_requests
  end
end
