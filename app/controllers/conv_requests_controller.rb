class ConvRequestsController < ApplicationController
  
  before_filter :asset_required, :only => [:new]
  
  def new
    @conv_request = ConvRequest.new
    @user = User.find_by_ip_address(request.remote_ip)
  end
  
  def create
    @conv_request = ConvRequest.new(params[:conv_request])
    @asset = Asset.find(params[:conv_request][:asset_id])
    if @conv_request.save
      flash[:message] = 'You request has been saved. We\'ll notify you soon.'
      redirect_to '/'
    else
      render :action => 'new'
    end
  end
  
  private
  def asset_required
    @asset = Asset.find(params[:asset_id])
    redirect_to '/' unless @asset 
  end
  
end
