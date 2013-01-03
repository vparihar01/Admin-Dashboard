require 'spec_helper'

describe Role do
  it "should have and belongs to many users" do
    role = Role.reflect_on_association(:users)
    role.macro.should == :has_and_belongs_to_many
  end
end