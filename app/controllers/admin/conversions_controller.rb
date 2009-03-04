class Admin::ConversionsController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  
  def index
    @conversions = Conversion.find(:all)
  end
  
  def show
    @conversion = Conversion.find(params[:id])
    if @conversion.exception.blank?
      send_file(@conversion.full_filename.gsub('docx', 'doc'), :filename => @conversion.filename.gsub('docx', 'doc'))
    else
      send_file(@conversion.full_filename, :filename => @conversion.filename)
    end
  end  
end