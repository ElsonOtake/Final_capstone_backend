class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :create, User
      can :create, Booking, user_id: user.id
    end
  end
end
