require 'digest/md5'

class AuthToken < ActiveRecord::Base
  validates_presence_of :token
  validates_presence_of :asset
  validates_presence_of :token_expires
  
  validates_uniqueness_of :asset_id
  
  belongs_to :asset
  
  before_validation :generate_token
  
  def ok?(token)
    !expired? and self.token == token 
  end
  
  private
  
  def expired?
    Time.now < self.token_expires
  end
  
  def generate_token
    self.token = Digest::MD5.hexdigest(self.asset.filename + Time.now.to_s)
    self.token_expires = Time.now + 10.days
  end
  
end
