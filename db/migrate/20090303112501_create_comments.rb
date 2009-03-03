class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :name
      t.string :email
      
      t.text :body
      t.string :ip_address

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
