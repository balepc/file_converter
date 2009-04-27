class BannersController < ApplicationController
  
  def click
    banner = Banner.find(params[:id])
    redirect_to banner.url
  end
  
end
