class AssetsController < ApplicationController
  include KeywordsHelper
  
  before_filter :find_asset, :only => [:show, :convert]
  before_filter :permission_required, :only => [:show, :convert]
  
  def new
    @asset = Asset.new
  end
  
  def show
    @full_text = @asset.content_full_text
    @keywords =  @asset.content_keywords
  end
  
  def create
    asset = Asset.new(params[:conversion].merge(:ip_address => request.remote_ip))  if params[:conversion]
    if asset and asset.save and asset.valid_from_format?
      extract_keywords(asset)
      
      redirect_to asset_path(asset)
    elsif params[:conversion].nil? or params[:conversion][:uploaded_data].blank?
      flash[:message] = 'File not specified'
      redirect_to '/'
    else
      AdminNotifier.deliver_wrong_format(asset.filename)
      flash[:message] = 'Unsupported format' unless asset.valid_from_format?
      flash[:message] ||= 'Failed to upload your file. Use "Feedback" tab to inform about your problem'
      redirect_to '/'
    end
  end
  
  def convert
    conversion = Conversion.convert(@asset, params[:format])
    if (conversion.converted?)
      send_file(conversion.result_filename, :filename => File.basename(conversion.result_filename) )
    else
      AdminNotifier.deliver_cant_convert(@asset.filename)
      flash[:message] = 'Failed to convert your file. Please use the "Feedback" tab to describe your problem'
      redirect_to '/'
    end
  end
  
  private
  def permission_required
    redirect_to '/' unless (admin? || owner? || token? || google?)
  end
  
  def find_asset
    @asset = Asset.find(params[:id])
  end
  
  def extract_keywords(asset)
    if asset.docx?
      conversion = Conversion.convert(asset, 'txt')
    elsif asset.xlsx?
      conversion = Conversion.convert(asset, 'csv')
    end
    if conversion and conversion.converted?
      full_text = File.read(conversion.result_filename)
      asset.update_attribute(:content_full_text, full_text)
      asset.update_attribute(:content_keywords, get_frequences(full_text).join(','))
    end
  end
  
end
