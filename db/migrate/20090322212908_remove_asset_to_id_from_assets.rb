class RemoveAssetToIdFromAssets < ActiveRecord::Migration
  def self.up
    remove_column(:conversions, :asset_to_id)
  end

  def self.down
  end
end
