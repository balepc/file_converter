class AuthController < ApplicationController
  
  def  login
    if params[:username] == 'google' and params[:password] == 'google'
      session[:google] = true
      redirect_to '/'
    end
  end
  
end
