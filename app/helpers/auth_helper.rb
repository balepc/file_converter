module AuthHelper
  
  def admin?
    request.remote_ip == '83.99.195.212'
  end
  
  def owner?
    @asset.user == User.find_by_ip_address(request.remote_ip)
  end
  
  def token?
    @asset.token.ok?(params[:token])
  end
  
end
