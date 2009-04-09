class AddNewMimeTypes < ActiveRecord::Migration
  def self.up
    AssetType.create(:code => 'doc', :mime_type=>'application/doc')
  end

  def self.down
  end
end
