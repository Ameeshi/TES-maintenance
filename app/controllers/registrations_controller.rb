class RegistrationsController < Devise::RegistrationsController
  
#  See Devise Update function before editing
  
#  def update
#    if @user.update(account_update_params)
#      redirect_to user_path(@user), notice: "Successfully updated #{@user.name}."
#    else
#      render action: 'edit'
#    end
#  end
  
  
  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :current_password)
  end
end
