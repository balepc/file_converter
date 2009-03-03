class AddIpAddressToConvertion < ActiveRecord::Migration
  def self.up
    add_column :conversions, :ip_address, :string
  end

  def self.down
    remove_column :conversions, :ip_address
  end
end