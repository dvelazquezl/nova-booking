class OwnerAbility
  include CanCan::Ability

  def initialize(user)
    #Si el usuario está logueado
    if user.present?
      if user.has_role? :admin
        can :manage, :all
      else
        owner = Owner.find_by user_id: user.id
        can :show, Owner, id: owner.id
        can :create, Owner
        can :change_profile_picture, Owner
        can :contact, Owner
        if owner
          can :update, Owner, id: owner.id
        end
      end
    else
      #Usuario visitante
      can :contact, Owner
    end

  end
end