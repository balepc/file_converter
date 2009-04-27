class Banner < ActiveRecord::Base
  
  validates_presence_of :code
  validates_uniqueness_of :code
  validates_presence_of :url
  
  def self.corrupted
    self.find_by_code('corrupted')
  end
  
  def click!
    self.update_attributes(:clicks, self.clicks + 1)
  end
  
end
