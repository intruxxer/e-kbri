class StatisticsController < ApplicationController
  before_filter :authenticate_user!
  before_action :not_admin
  
  def index

  end
  
  def not_admin
    if !current_user.has_role? :admin 
      redirect_to root_path, :warning => 'There is no page exist for your request.'
    end
  end
  
end