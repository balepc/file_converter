class Asset < ActiveRecord::Base
  
  has_attachment :path_prefix => 'public/assets',
    :max_size => 100.megabytes
  
  validates_presence_of :filename
  validates_presence_of :size
  
  has_many :conversions
  has_one :auth_token
  belongs_to :user
  
  after_save :generate_token

  def valid_from_format?
    self.asset_type.valid_from_format? if self.asset_type
  end
  
  def asset_type
    AssetType.find_by_mime_type self.content_type
  end
  
  def ip_address=(ip_address)
    self.user = User.get(ip_address)
  end
  
  private
  def generate_token
    AuthToken.create(:asset => self) if self.auth_token.nil?
  end
  
end
