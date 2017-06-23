class UserMailer < ApplicationMailer
require 'mailgun'
default from: ENV['gmail_username']
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.UserMailerView.subject
  #
  def UserMailerView(user)
    @user = user
    @greeting = "Hi"

    mail to: @user.email
  end


  def sample_email(user)
    @user = user
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      :to      => @user.email,
                      :subject => 'Sample Mail using Mailgun API',
                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    mg_client.send_message ENV['domain'], message_params
  end

  def UserMailerView(user)
    @user = user
   mail(to: @user.email, subject: 'Sample Email')
  end
end
