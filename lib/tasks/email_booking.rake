namespace :email_booking do
  desc "Enviar un correo al usuario pidiendo que valore la propiedad"
  task request_assess: :environment do
    UserMailer.email_prueba.deliver_now
  end
end
