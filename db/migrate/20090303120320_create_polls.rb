class CreatePolls < ActiveRecord::Migration
  def self.up
    create_table :polls do |t|
      t.string :answer
      t.string :ip_address
      t.timestamps
    end
  end

  def self.down
    drop_table :polls
  end
end
