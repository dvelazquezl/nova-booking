namespace :email_booking do
  desc "Enviar un correo al usuario pidiendo que valore la propiedad"
  task request_assess: :environment do
    bookings = Booking.request_assess
    bookings.each do |booking|
      UserMailer.email_request_assess(booking).deliver_now
      booking.notified = TRUE
      booking.save
    end
  end
end
