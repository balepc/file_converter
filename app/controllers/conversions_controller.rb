class ConversionsController < ApplicationController
  
  def create
    @conversion = Conversion.new(params[:conversion])
    @conversion.ip_address = request.remote_ip
    if @conversion.save
      send_file(@conversion.full_filename.gsub('docx', 'doc'), :filename => @conversion.filename.gsub('docx', 'doc'))
#      filename = @conversion.full_filename.gsub('docx', 'doc')
#      response.headers['Content-Type'] = "application/force-download"
#      response.headers['Content-Disposition'] = "attachment; filename=#{File.basename(filename)}"
#      response.headers["X-Sendfile"] = filename
#      response.headers['Content-length'] = File.size(filename)
#      render :nothing => true
    else
      AdminNotifier.deliver_wrong_format(@conversion.filename)
      flash[:message] = 'Failed to convert'
      redirect_to '/'
    end
  end

end
