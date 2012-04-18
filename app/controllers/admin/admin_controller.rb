class Admin::AdminController < ApplicationController
  layout "admin"
  before_filter :verify_admin
  def verify_admin
    @user = current_user
    redirect_to root_url unless @user.role? "admin"
  end

  def current_ability
    @current_ability ||= AdminAbility.new(current_user)
  end
end
