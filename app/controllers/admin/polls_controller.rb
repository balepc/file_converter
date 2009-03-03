class Admin::PollsController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  
  def index
    @polls = Poll.find(:all)
  end
end
