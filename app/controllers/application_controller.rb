class ApplicationController < ActionController::Base

  before_action :authenticate!,except: [:top]
  def authenticate!
    if admin_signed_in?
      authenticate_admin!
    else
      authenticate_end_user!
    end
  end
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :is_deletd])
  end
end
