class BookingAbility
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.has_role? :admin
      #Usuario admin.
      can :manage, :all
      else
        #owner existe si user tiene asociado un perfil de propietario
        owner ||= Owner.find_by user_id: user.id

        #Logueado
        can :create, Booking
        can :index_user, Booking
        can :show, Booking, client_email: user.email
        can :destroy, Booking, client_email: user.email
        can :cancel_my_booking, Booking
        can :cancel, Booking

        #Solo un user con perfil de owner
        if owner
          can :index_owner, Booking
          can :cancel_booking_owner, Booking
          can :show_detail, Booking
        end
      end
    else
      #Visitantes
      can :create, Booking
      can :show, Booking
      can :confirmation, Booking
    end
  end
end