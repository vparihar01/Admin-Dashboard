require 'spec_helper'

describe Post do
  it "should belongs to user" do
    post = Post.reflect_on_association(:user)
    post.macro.should == :belongs_to
  end
end