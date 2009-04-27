class Admin::ConvRequestsController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  
  def index
    @conv_requests = ConvRequest.find(:all)
  end
  
end
