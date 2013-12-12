class DashboardController < ApplicationController
  before_filter :authenticate_user!
  #if user_signed_in?, current_user.full_name, etc. 
  
  def index
    #because layouts/dashboard.html.erb exists in views-->go to that
    #else, got to dashboard/index.html.erb
  end
end
