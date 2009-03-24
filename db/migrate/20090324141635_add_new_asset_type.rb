class AddNewAssetType < ActiveRecord::Migration
  def self.up
    AssetType.create(:code => 'docx', :mime_type=>'application/x-zip-compressed')
  end

  def self.down
  end
end
