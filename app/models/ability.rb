class Ability
  include CanCan::Ability

  def initialize(current_user)
    return unless current_user

    if current_user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can %i[create], User
      can %i[create], Booking, { user_id: current_user.id }
    end
  end
end
