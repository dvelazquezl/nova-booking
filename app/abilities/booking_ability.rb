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
        can :read, Booking, client_email: user.email
        can :delete, Booking, client_email: user.email
      end
    else
      #Visitantes
      can :create, Booking
      can :read, Booking
    end
  end
end