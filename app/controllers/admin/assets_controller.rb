class Admin::AssetsController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  
  def index
    @assets = Asset.paginate(:all, 
      :conditions => Condition.block { |c|
        c.and "filename", 'LIKE', "%#{params[:asset][:filename]}%" if params[:asset] and !params[:asset][:filename].blank?
      }, :order => 'created_at DESC', :per_page => 150, :page => params[:page])
    
    
#    @assets = Asset.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 100
  end
  
  def download
    @asset = Asset.find(params[:id])
    send_file(@asset.full_filename, :filename => File.basename(@asset.full_filename) )
  end
  
end