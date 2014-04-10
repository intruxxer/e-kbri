class Users::PasswordsController < Devise::PasswordsController

  def new
    super
  end
  
  def create
    super
  end
  

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :reset_password_token)
  end
  private :resource_params
end
