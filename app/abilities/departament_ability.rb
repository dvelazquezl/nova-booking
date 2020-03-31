class DepartamentAbility
  include CanCan::Ability

  def initialize(user)
    if user.present? and user.has_role? :admin
      can :manage, :all
    end
  end
end