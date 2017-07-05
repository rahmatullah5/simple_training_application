class UserMailer < ApplicationMailer
  require 'mailgun'
  default from: ENV['gmail_username']

  def sample_email(user)
    mail to: user
  end

  def UserMailerView(order,cart,user)
    @order = order
    @cart = cart
    # mg_client = Mailgun::Client.new ENV['api_key']
    # message_params = {:from    => ENV['gmail_username'],
    #   :to      => user,
    #   :subject => 'Thanks For Orders Our Product',
    #   :html => render_to_string(
    #     template_path: 'user_mailer',
    #     template_name: 'usermailerview'
    #   )
    #   # :text    => 'Hi , Thanks You For Bought Our Product'
    #   # :html => render_to_string(
    #   #   template: '/user_mailer/usermailerview',
    #   #   formats: [:html],
    #   #   locale: [:en]
    #   # )
    #
    # }
    # mg_client.send_message ENV['domain'], message_params
    mail to: user
  end
end
