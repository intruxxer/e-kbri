class Users::RegistrationsController < Devise::RegistrationsController

  include SimpleCaptcha::ControllerHelpers
  before_filter :configure_permitted_parameters # before_filter :resource_params
  def new
    super # no customization, simply call the devise implementation
    @ip_visitor = request.remote_ip
    message_one = "Dear Visitor,  Please kindly be notified that your IP address & Location is automatically 
                         logged for security monitoring during your active access to E-KBRI."
    message_two = "Your IP address is<b> #{@ip_visitor} </b>."
    warning = [ message_one, message_two ]
    flash[:alert] = warning.join("<br/>").html_safe
  end
  
  # POST /user
  def create    
    build_resource(sign_up_params)
    if simple_captcha_valid?    
      resource_saved = resource.save
      yield resource if block_given?
      if resource_saved
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        @errors = resource.errors.messages
        clean_up_passwords resource
        respond_with resource
      end
    else
      #captcha error
      @errors = { 'Secret Code' => 'Wrong Code Entered'}
      render "new"
    end
  end
  
  def update
    #super
    updated_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, 
                    :current_password, :citizenship, :origin, :individual, :passport, :id_card)
    change_password = true
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
      params[:user].delete("current_password")
      updated_params = params.require(:user).permit(:first_name, :last_name, :email, :citizenship, :origin, :individual, :passport, :id_card)
      change_password = false
    end
    
    @user = User.find(current_user.id)
    is_valid = false
    
    if change_password
      is_valid = @user.update_with_password(updated_params)
    else
      is_valid = @user.update_without_password(updated_params)      
    end
    
    if is_valid
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      @errors = @user.errors.messages
      render "edit"
    end
  end
  
  

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
