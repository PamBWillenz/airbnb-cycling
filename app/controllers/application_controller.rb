class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  alias_method :current_user, :current_member

  rescue_from Pundit::NotAuthorizedError, with: :member_not_authorized
  private
  def member_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  protected

  def after_sign_up_path_for(resource)
    new_member_profile_path(@member)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
