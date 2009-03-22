class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :ip_address
      t.timestamps
    end
    
    add_column :assets, :user_id, :integer
    add_column :conversions, :user_id, :integer
  end

  def self.down
    drop_table :users
  end
end
