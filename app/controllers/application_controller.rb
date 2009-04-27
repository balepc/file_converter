# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable
  include AuthHelper
  
  helper :all # include all helpers, all the time
  protect_from_forgery # :secret => '5860b3174e338b3efa55ecb2402ceb12'
  
  before_filter :get_format
  
  def authenticate
#    authenticate_or_request_with_http_basic do |username, password|
#      username == "admin" && password == "admin"
#    end
    admin?
  end
  
  def site_name
    'converter.tds.lv'
  end
  
  def get_format
    match = request.host.match(/([a-z]{3,})\.oconvert.com/)
    
    @ext = match[1] if match.size > 1 if match
    @ext ||= 'docx'
    
    format = Format.find_by_code(@ext)
    if format
      @title = format.title
      @keywords = format.keywords
      @description = format.description
      @text = format.text
    end
  end
  
end
