class ApplicationController < ActionController::Base
  # load_and_authorize_resource
  protect_from_forgery
  before_action :current_user
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # @current_user = User.find_by_authe
  # puts @current_user.username
  # @current_user = 1
  # puts @current_user.email

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    # devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:studentid, :password, :remember_me) }
    # devise_parameter_sanitizer.permit(:account_update) { |u| u.permit( :studentid, :email, :password, :password_confirmation, :current_password) }
  end
end
