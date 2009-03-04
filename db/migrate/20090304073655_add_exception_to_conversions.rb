class AddExceptionToConversions < ActiveRecord::Migration
  def self.up
    add_column :conversions, :exception, :string
    add_column :conversions, :filesize, :integer
  end

  def self.down
    remove_column :conversions, :filesize
    remove_column :conversions, :exception
  end
end
