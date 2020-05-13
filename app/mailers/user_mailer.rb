class UserMailer < ApplicationMailer
  def new_booking(booking)
    @booking =booking
    @estate = Estate.find(Room.find(@booking.booking_details[0].room_id).estate_id)
    @user_email = user_email(booking)
    @diff = Booking.diff(@booking)
    @plural_arg= (@diff > 1)? "s":" "
    make_bootstrap_mail(to: booking.client_email, subject: 'NovaBooking!')
  end

  def new_booking_owner(booking)
    @booking =booking
    @estate = Estate.find(Room.find(@booking.booking_details[0].room_id).estate_id)
    @diff = Booking.diff(@booking)
    @plural_arg = (@diff > 1)? "s":" "
    user_email = user_email(booking)
    mail(to: user_email, subject: 'NovaBooking!')
  end


  def unsuscribe_estate(estate, booked_rooms)
    @estate = estate
    @owner = Owner.find(@estate.owner_id)
    @booking = Booking.find(BookingDetail.find_by_room_id(booked_rooms[0].id).booking_id)
    @user_email = user_email(@booking)
    mail(to: @booking.client_email, subject: 'NovaBooking! - Cancelacion de reserva')
  end
  def new_booking_confirmation(booking)
    @booking =booking
    @estate = Estate.find(Room.find(@booking.booking_details[0].room_id).estate_id)
    @diff = Booking.diff(@booking)
    @plural_arg = (@diff > 1)? "s":" "
    mail(to: booking.client_email, subject: 'NovaBooking!')
  end

  def email_request_assess(booking)
    @booking = booking
    @diff = Booking.diff(@booking)
    @estate = Estate.find(Room.find(@booking.booking_details[0].room_id).estate_id)
    @plural_arg = (@diff > 1)? "s":" "
    mail(to: booking.client_email, subject: 'NovaBooking!')
  end

  def booking_cancelled_by_owner_to_owner(booking)
    @booking = booking
    @estate = Estate.find(Room.find(@booking.booking_details[0].room_id).estate_id)
    user_email = user_email(booking)
    mail(to: user_email, subject: 'NovaBooking! - Cancelacion de reserva')
  end
  def booking_cancelled_by_owner_to_client(booking)
    @booking = booking
    @estate = Estate.find(Room.find(@booking.booking_details[0].room_id).estate_id)
    @owner = Owner.find(@estate.owner_id)
    @user_email = user_email(booking)
    mail(to: booking.client_email, subject: 'NovaBooking! - Cancelacion de reserva')
  end
  def booking_cancelled_by_user_to_owner(booking)
    @booking = booking
    @estate = Estate.find(Room.find(@booking.booking_details[0].room_id).estate_id)
    @client_email = booking.client_email
    @client_name = booking.client_name
    @cancellation_motive = translate_to_spanish(booking.cancellation_motive)
    user_email = user_email(booking)
    mail(to: user_email, subject: 'NovaBooking! - Cancelacion de reserva')
  end
  def booking_cancelled_by_user_to_user(booking)
    @booking = booking
    @estate = Estate.find(Room.find(@booking.booking_details[0].room_id).estate_id)
    @user_email = user_email(booking)
    mail(to: booking.client_email, subject: 'NovaBooking! - Cancelacion de reserva')
  end

  private
    #se obtiene el email del propietario
    def user_email(booking)
      estate_id = Room.find_by_id(booking.booking_details.first.room_id).estate_id
      estate = Estate.find_by_id(estate_id)
      user_id= Owner.find_by_id(estate.owner_id).user_id
      user_email = User.find_by_id(user_id).email
      return user_email
    end

    def translate_to_spanish(cancellation_motive)
      case cancellation_motive
      when "change_of_date"
        "Cambio de fechas"
      when "personal_motive"
        "Motivos personales/el viaje ha sido cancelado"
      when "more_than_one_booking"
        "Mas de una reserva en la misma fecha y deseo cancelar las que no necesito"
      when "better_option"
        "He econtrado una mejor opcion"
      when "none_of_the_above"
        "No especificado"
      end
    end
end
