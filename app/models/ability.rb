class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :create, User
    return unless user

    if user.role == 'admin'
      can :manage, :all
    else
      can :create, Booking, user_id: user.id
    end
  end
end
