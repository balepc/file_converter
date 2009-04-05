class CreateBlockedIps < ActiveRecord::Migration
  def self.up
    create_table :blocked_ips do |t|
      t.string :ip_address, :null => false
      t.integer :attempts, :default => 0, :null => false
      t.string :status, :null => false, :default => 'none'
      t.timestamps
    end
    
    add_index(:blocked_ips, :ip_address)
  end

  def self.down
    drop_table :blocked_ips
  end
end
