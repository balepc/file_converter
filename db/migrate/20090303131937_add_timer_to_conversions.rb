class AddTimerToConversions < ActiveRecord::Migration
  def self.up
    add_column :conversions, :spent, :float
    add_column :conversions, :converted, :boolean
  end

  def self.down
    remove_column :conversions, :converted
    remove_column :conversions, :spent
  end
end
