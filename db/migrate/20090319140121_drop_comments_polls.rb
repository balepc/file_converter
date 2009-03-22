class DropCommentsPolls < ActiveRecord::Migration
  def self.up
    drop_table :comments
    drop_table :polls
  end

  def self.down
  end
end
