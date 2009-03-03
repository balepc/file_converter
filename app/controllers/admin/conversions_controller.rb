class Admin::ConversionsController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  
  def index
    @conversions = Conversion.find(:all)
  end
  
  def show
    @conversion = Conversion.find(params[:id])
    send_file(@conversion.full_filename.gsub('docx', 'doc'), :filename => @conversion.filename.gsub('docx', 'doc'))
  end  
end