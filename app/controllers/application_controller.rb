class ApplicationController < ActionController::Base
  protect_from_forgery
  # Mandatory authentication
#  def authenticate_user!
#    CASClient::Frameworks::Rails::Filter.filter(self)
#  end
#
## Optional authentication (not in Devise)
#  def authenticate_user
#    CASClient::Frameworks::Rails::GatewayFilter
#  end
#
#  def user_signed_in?
#    session[:cas_user].present?
#  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def has_role?(current_user, role)
    return !!current_user.roles.find_by_name(role.to_s.camelize)
  end

end
