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

  #def after_sign_in_path_for(resource)
  #  resource.roles == 'admin' ? admin_dashboard_path : user_path(resource)
  #end
  #
  #def authenticate_admin_user!
  #  raise SecurityError unless current_user.try(:role) == 'admin'
  #end

  def check_admin_role
    return if current_user.role?(:admin)
    flash[:notice] = "You need to be an admin to access this part of the application"
    redirect_to root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def has_role?(current_user, role)
    return !!current_user.roles.find_by_name(role.to_s.camelize)
  end

end
