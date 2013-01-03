require 'spec_helper'

describe PostsController do

  before(:each) do
    @user = Factory(:user, :role_ids => [Factory(:admin).id])
    @ability = @user
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end


  describe "GET index" do
    it "should show the posts list page" do
      @ability.can :read, Post
      get :index
      assert_template :index
    end
  end

  describe 'GET new' do
    it "should show the new post page " do
      @ability.can :create, Post
      get :new
      response.code.should == "200"
    end
  end

  describe 'GET edit' do
    it "should show the edit post page " do
      @ability.can :create, Post
      @post = Factory(:post, :user_id => @user.id)
      get :edit, :id => @post.id
    end
  end


end