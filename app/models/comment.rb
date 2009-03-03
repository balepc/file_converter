class Comment < ActiveRecord::Base
  
  validates_presence_of :email
  validates_presence_of :name
end
