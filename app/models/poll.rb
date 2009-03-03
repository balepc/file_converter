class Poll < ActiveRecord::Base
  
  validates_presence_of :ip_address
  validates_uniqueness_of :ip_address
end
