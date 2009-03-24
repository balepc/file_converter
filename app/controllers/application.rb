# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable
  helper :all # include all helpers, all the time
  protect_from_forgery # :secret => '5860b3174e338b3efa55ecb2402ceb12'
  
  def authenticate
#    authenticate_or_request_with_http_basic do |username, password|
#      username == "admin" && password == "admin"
#    end
    admin?
  end
  
  def site_name
    'converter.tds.lv'
  end
  
end
