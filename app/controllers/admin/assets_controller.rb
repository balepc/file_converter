class Admin::AssetsController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  
  def index
    @assets = Asset.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 100
  end
  
  def download
    @asset = Asset.find(params[:id])
    send_file(@asset.full_filename, :filename => File.basename(@asset.full_filename) )
  end
  
end