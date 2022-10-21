class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, Booking, user:
  end
end
