require 'spec_helper'

describe ProfilesController do

  before(:each) do
    @user = Factory(:user, :role_ids => [Factory(:admin).id])
    @ability = @user
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  describe "GET dashboard" do
    it "should authenticate as admin" do
      sign_in @user
      get :dashboard
      response.should redirect_to admin_dashboard_url
    end

    it "should authenticate as staff" do
      @staff = Factory(:staff, :role_ids => [Factory(:role).id])
      sign_in @staff
      get :dashboard
      response.code.should == "200"
    end

    it "should not authenticate" do
      get :dashboard
      response.should_not redirect_to admin_dashboard_url
    end
  end

end