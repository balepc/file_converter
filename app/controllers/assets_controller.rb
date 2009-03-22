class AssetsController < ApplicationController
  
  def new
    @asset = Asset.new
  end
  
  def show
    @asset = Asset.find(params[:id])
  end
  
  def create
    asset = Asset.new(params[:conversion])
    if asset.save and asset.valid_from_format?
      redirect_to asset_path(asset)
    else
      AdminNotifier.deliver_wrong_format(asset.filename)
      flash[:message] = 'Unsupported format' unless asset.valid_from_format?
      flash[:message] ||= 'Failed to upload your file. Use "Feedback" tab to inform about your problem'
      redirect_to '/'
    end
  end
  
  def convert
    asset = Asset.find(params[:id])    
    conversion = Conversion.convert(asset, params[:format])
    if (conversion.converted?)
      send_file(conversion.result_filename, :filename => File.basename(conversion.result_filename) )
    else
      AdminNotifier.deliver_cant_convert(asset.filename)
      flash[:message] = 'Failed to convert your file. Please use the "Feedback" tab to describe your problem'
      redirect_to '/'
    end
  end
  
end
