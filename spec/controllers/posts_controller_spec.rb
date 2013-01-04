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
      assert_template :new
    end
  end

  describe 'GET edit' do
    it "should show the edit post page " do
      @ability.can :update, Post
      @post = Factory(:post, :user_id => @user.id)
      get :edit, :id => @post.id
      assert_template :edit
    end
  end

  describe 'POST create' do
    context "with valid attributes" do
      it "should create a new post" do
        @ability.can :create, Post
        expect{
          post "create", :post => Factory.attributes_for(:post, :user_id => @user.id)
        }.to change(Post,:count).by(1)
      end

      it "redirects to the Post page" do
        @ability.can :create, Post
        post "create", :post => Factory.attributes_for(:post, :user_id => @user.id)
        #Rails.logger.debug "############################################################{response.body.inspect}"
        response.should be_redirect
      end
    end

    context "with invalid attributes" do
      it "does not creates a new offer" do
        expect{
          post "create_offer", :offer => Factory.attributes_for(:invalid_offer)
        }.not_to change(Offer,:count)
      end

      it "re-renders to the create new Offer form" do
        post "create_offer", :offer => Factory.attributes_for(:invalid_offer)
        response.should render_template :new
      end
    end
  end



end