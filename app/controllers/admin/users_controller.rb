class Admin::ConversionsController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  
  def index
    @users = User.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 100
  end
  
end