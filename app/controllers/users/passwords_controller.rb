class Users::PasswordsController < Devise::PasswordsController

  def new
    super
  end
    
  # POST /users/password
  def create
    #super
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      set_flash_message(:warning, :no_email)
      respond_with(resource)
      #redirect_to new_session_path(resource_name)
    end
  end

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :reset_password_token)
  end
  private :resource_params
end
