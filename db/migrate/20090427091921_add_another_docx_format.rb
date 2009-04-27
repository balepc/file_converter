class AddAnotherDocxFormat < ActiveRecord::Migration
  def self.up
    AssetType.create(:code => 'doc', :mime_type=>'application/vnd.ms-word.document.12')
    AssetType.create(:code => 'doc', :mime_type=>'application/octet_stream')
  end

  def self.down
  end
end
