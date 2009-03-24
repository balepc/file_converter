class AddRtfFormat < ActiveRecord::Migration
  def self.up
    AssetType.create(:code => 'rtf', :mime_type=>'application/rtf')
  end

  def self.down
  end
end