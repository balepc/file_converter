class CommentsController < ApplicationController
  
  def index
    @comments = Comment.find(:all)
  end
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.ip_address = request.remote_ip
    if @comment.save
      redirect_to comments_path
    else
      render :action => 'index'
    end
  end
  
end
