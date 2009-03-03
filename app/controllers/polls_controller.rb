class PollsController < ApplicationController
  
  def create
    @poll = Poll.new(params[:poll])
    @poll.ip_address = request.host
    @poll.save
    
    session[:poll_id] = @poll
    
    redirect_to comments_path
  end
  
end
