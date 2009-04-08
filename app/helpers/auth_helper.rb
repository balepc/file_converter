module AuthHelper
  
  def admin?
    request.remote_ip == '83.99.195.212'
  end
  
  def owner?
    @asset.user == User.find_by_ip_address(request.remote_ip)
  end
  
  def token?
    @asset.auth_token.ok?(params[:token])
  end
  
  def google?
    session[:google] == true
  end
  
end
