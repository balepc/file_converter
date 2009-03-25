class AddPptxFormats < ActiveRecord::Migration
  def self.up
    AssetType.create(:code => 'pptx', :mime_type=>'application/vnd.openxmlformats-officedocument.presentationml.presentation')
    AssetType.create(:code => 'ppt', :mime_type=>'application/vnd.ms-powerpoint')
    AssetType.create(:code => 'odp', :mime_type=>'application/vnd.oasis.opendocument.presentation')
  end

  def self.down
  end
end
