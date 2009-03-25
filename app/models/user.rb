class User < ActiveRecord::Base
  
  validates_presence_of :ip_address
  has_many :assets
  
  def User.get(ip_address)
    unless (user = User.find_by_ip_address(ip_address))
      user = User.create(:ip_address => ip_address)
    end
    user
  end
  
end
