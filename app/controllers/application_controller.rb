class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
  
  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      flash[:error] = "Access denied on #{exception.action} #{exception.subject.inspect}"
      redirect_to root_url
    else
      flash[:error] = "Please Sign in"
      redirect_to new_user_session_path
    end
  end
  
end
