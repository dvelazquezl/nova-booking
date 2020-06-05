class SendgridMailer < ApplicationMailer
  default :from => 'novabooking20@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(users)
    @users = users
    mail( :to => @users.email,
          :subject => 'Thanks for signing up for our amazing app' )
  end
end
