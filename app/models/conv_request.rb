class ConvRequest < ActiveRecord::Base
  include ActionController::UrlWriter

  
  validates_presence_of :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  before_save :link_user_to_email
  after_save :notify_admin
  
  belongs_to :user
  belongs_to :asset
  
  
  private
  def link_user_to_email
    if user
      user.update_attribute(:email, email)
    end
  end
  
  def notify_admin
    AdminNotifier.deliver_conv_request(self, "http://oconvert.com#{admin_conv_request_path(self)}")
  end
  
end
