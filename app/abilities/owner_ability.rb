class OwnerAbility
  include CanCan::Ability

  def initialize(user)
    #Si el usuario está logueado
    if user.present?
      if user.has_role? :admin
        can :manage, :all
      else
        owner = Owner.find_by user_id: user.id
        can :read, Owner
        can :create, Owner
        if owner
          can :update, Owner, id: owner.id
        end
      end
    else
      #Usuario visitante
      can :read, Owner
    end

  end
end