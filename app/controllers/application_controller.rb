class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :check_registration
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  def after_sign_in_path_for(resource)
    if current_user.has_role? :admin
      dashboard_path
    else
      authenticated_root_path
    end
  end


  private

  def check_registration
    if current_user && !current_user.valid?
      flash[:warning] = "Please finish your #{view_context.link_to "registration", edit_user_registration_url }  before continuing.".html_safe
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| 
      u.permit(:username, :first_name, :last_name, :email, :passport, :id_card, :citizenship, :origin, :individual, :password, :password_confirmation, :current_password, :roles => []) }
  end


end
