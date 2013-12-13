class DashboardController < ApplicationController
  before_filter :authenticate_user!
  #if user_signed_in?, current_user.full_name, etc. 
  layout "dashboard"
  
  def index
    @content = "index"
    
  end
  
  def immigration
    @content = "immigration"
    
  end
  
  
  
end
