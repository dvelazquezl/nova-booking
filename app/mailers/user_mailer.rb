class UserMailer < ApplicationMailer
  def new_booking
    mail(to: "ricardo.gonzalez@fiuni.edu.py", subject: 'NovaBooking!')
  end
end
