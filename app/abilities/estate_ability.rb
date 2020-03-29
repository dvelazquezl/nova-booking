 class EstateAbility
    include CanCan::Ability

    def initialize(user)
      #owner existe si user tiene asociado un perfil de propietario
      owner ||= Owner.find_by user_id: user.id

      if user.has_role? :admin
        can :manage, :all
      else
        #Visitantes y usuarios logueados
        can :read, Estate
        can :create, Estate
        #Solo un user con perfil de owner
        if owner
          can :update, Estate, owner_id: owner.id
          can :delete, Estate, owner_id: owner.id
        end
      end
    end
 end