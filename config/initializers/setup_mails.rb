ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address              =>  'smtp.sendgrid.net',
    :port                 =>  '587',
    :authentication       =>  :plain,
    :user_name            =>  'angel-marecos',
    :password             =>  'leirbag27',
    :domain               =>  'heroku.com',
    :enable_starttls_auto  =>  true
}
