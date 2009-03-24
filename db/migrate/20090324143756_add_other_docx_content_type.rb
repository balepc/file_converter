class AddOtherDocxContentType < ActiveRecord::Migration
  def self.up
    AssetType.create(:code => 'docx', :mime_type=>'application/docXConverter')
  end

  def self.down
  end
end
