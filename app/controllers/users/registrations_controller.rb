class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters # before_filter :resource_params
    
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
    	u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :passport, :id_card, :citizenship, :origin, :individual)
    end
    
    devise_parameter_sanitizer.for(:account_update) do |u|
    	u.permit(:first_name, :last_name, :email, :passport, :id_card, :citizenship, :origin, :individual, :password, :password_confirmation, :current_password)
    end
  end
  
  #def resource_params
  #  params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  #end
  #private :resource_params
end
