class Asset < ActiveRecord::Base
  
  has_attachment :path_prefix => 'public/assets',
    :max_size => 100.megabytes
  
  validates_presence_of :filename
  validates_presence_of :size
  
  has_many :conversions

  def valid_from_format?
    self.asset_type.docx?
  end
  
  def asset_type
    AssetType.find_by_mime_type self.content_type
  end
  
end
