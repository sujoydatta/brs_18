class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :create, Request
      can :update, Request do |request|
        request.try(:user) == user
      end
    end
  end
end
