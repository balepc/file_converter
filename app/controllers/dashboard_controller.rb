class DashboardController < ApplicationController
  
  def show
    @conversion = Conversion.new
  end
  
end
