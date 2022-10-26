class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    can :create, User
    # return unless user

    # if user.role == 'admin'
    can :manage, :all if user.is? :admin
    # else
    can :create, Booking, user_id: user.id
    # end
  end
end
