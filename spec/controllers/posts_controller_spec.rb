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

      it "should redirect to the Post page" do
        @ability.can :create, Post
        post "create", :post => Factory.attributes_for(:post, :user_id => @user.id)
        #Rails.logger.debug "############################################################{response.body.inspect}"
        response.should be_redirect
      end
    end

    context "with invalid attributes" do
      it "should not creates a new post" do
        @ability.can :create, Post
        expect{
          post "create", :post => Factory.attributes_for(:invalid_post, :user_id => @user.id)
        }.not_to change(Post,:count)
      end

      it "should re-renders to the new post page" do
        @ability.can :create, Post
        post "create", :post => Factory.attributes_for(:invalid_post, :user_id => @user.id)
        response.should render_template :new
      end
    end
  end

  describe 'PUT update' do

    before :each do
      @post = Factory(:post, :user_id => @user.id)
    end

    context "with valid attributes" do
      it "should locate the edit post page" do
        @ability.can :update, Post
        put "edit", :id => @post.id, :post => Factory.attributes_for(:post)
        assigns(:post).should eq(@post)
      end

      it "should update post" do
        @ability.can :update, Post
        put "update", :id => @post.id, :post => Factory.attributes_for(:post, :title => "test123")
        @post.reload
        @post.title.should eq("test123")
      end

      it "should redirect to the post page" do
        @ability.can :update, Post
        put "update", :id => @post.id, :post => Factory.attributes_for(:post, :title => "test123")
        response.should be_redirect
      end
    end

    context "with invalid attributes" do

      it "should not update post" do
        @ability.can :update, Post
        put "update", :id => @post.id, :post => Factory.attributes_for(:invalid_post)
        @post.reload
        @post.title.should_not eq(nil)
      end

      it "re-renders the edit page view" do
        @ability.can :update, Post
        put "update", :id => @post.id, :post => Factory.attributes_for(:invalid_post)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @post = Factory(:post, :user_id => @user.id)
    end

    it "should destroy the post" do
      @ability.can :destroy, Post
      expect{
        delete "destroy", :id => @post.id
      }.to change(Post,:count).by(-1)
    end

    it "should redirects to dashboard" do
      @ability.can :destroy, Post
      delete "destroy", :id => @post.id
      response.should redirect_to "/posts"
    end
  end

  describe 'GET show' do
    before :each do
      @post = Factory(:post, :user_id => @user.id)
    end

    it "should show the post" do
      @ability.can :read, Post
      get "show", :id => @post.id
      response.code.should =="200"
    end
  end

end