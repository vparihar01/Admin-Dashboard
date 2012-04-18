class AdminAbility
  include CanCan::Ability
  def initialize(user)
    if user.role? :admin
      can :manage, :all
    end
    # define admin abilities here ....
  end
end
