require 'spec_helper'

describe User do
  it "should have many posts" do
    user = User.reflect_on_association(:posts)
    user.macro.should == :has_many
  end

  it "should have and belongs to many roles" do
    user = User.reflect_on_association(:roles)
    user.macro.should == :has_and_belongs_to_many
  end

  describe "abilities" do
    subject { ability }
    let(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when is an registered" do
      let(:user){ Factory(:user, :role_ids => [Factory(:registered).id]) }
      it{ should be_able_to(:manage, Post.new(:user_id => user.id)) }
      it{ should_not be_able_to(:manage, User.new) }
    end

    context "when is an admin" do
      let(:user){ Factory(:user, :role_ids => [Factory(:admin).id]) }
      it{ should be_able_to(:manage, User.new()) }
    end

    context "when is an any user" do
      let(:user){ Factory(:user, :role_ids => [Factory(:role).id]) }
      it{ should be_able_to(:manage, Post.new()) }
      it{ should_not be_able_to(:manage, User.new) }
    end

  end

end