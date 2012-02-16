class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    can :manage, User, :id => user.id
    can :manage, Account, :user_id => user.id
    
    can :manage, Category, :user_id => user.id
  end
end
