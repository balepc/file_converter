class AssetTypes < ActiveRecord::Migration
  def self.up
    add_column :asset_types, :mime_type, :string, :length => 255
    
    AssetType.create(:code => 'docx', :mime_type => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document')
    AssetType.create(:code => 'pdf',  :mime_type => 'application/pdf')
    AssetType.create(:code => 'odt',  :mime_type => 'application/vnd.oasis.opendocument.text')
    AssetType.create(:code => 'doc',  :mime_type => 'application/msword')
    AssetType.create(:code => 'txt',  :mime_type => 'text/plain')
  end

  def self.down
  end
end
