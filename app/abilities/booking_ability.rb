class BookingAbility
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.has_role? :admin
      #Usuario admin.
      can :manage, :all
      else
        #Logueado
        can :create, Booking
        can :show, Booking, client_email: user.email
        can :destroy, Booking, client_email: user.email
      end
    else
      #Visitantes
      can :create, Booking
      can :show, Booking
      can :confirmation, Booking
    end
  end
end