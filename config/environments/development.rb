Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  config.action_mailer.delivery_method = :letter_opener
  #config.action_mailer.delivery_method = :smtp
  # SMTP settings for mailgun
  ActionMailer::Base.smtp_settings = {
    :port           => 587,
    :address        => "smtp.mailgun.org",
    :domain         => ENV['domain'],
    :user_name      => ENV['username'],
    :password       => ENV['password'],
    :authentication => :plain,
  }
  config.action_mailer.perform_deliveries = true
  config.active_job.queue_adapter = :sidekiq

  # GMAIL
  # config.action_mailer.smtp_settings = {
  #   :address              => "smtp.gmail.com",
  #   :port                 => 587,
  #   :user_name            => ENV['gmail_username'],
  #   :password             => ENV['gmail_password'],
  #   :authentication       => "plain",
  #   :enable_starttls_auto => true
  # }

  config.after_initialize do

    ## Paypal Configuration
    ActiveMerchant::Billing::Base.mode = :test
    paypal_options = {
      login: "Rahmatthea5-facilitator_api1.gmail.com",
      password: "2NFPGK58AA7YDCAH",
      signature: "AFcWxV21C7fd0v3bYYYRCpSSRl31AD7pqGsFaZQ663yBOAkHlLDqBMsV"
    }
    ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)


    ##Bullet Configuration
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    # Bullet.growl = true
    # Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
    #   :password => 'bullets_password_for_jabber',
    #   :receiver => 'your_account@jabber.org',
    # :show_online_status => true }
    Bullet.rails_logger = true
    # Bullet.honeybadger = false
    # Bullet.bugsnag = false
    # Bullet.airbrake = false
    # Bullet.rollbar = false
    Bullet.add_footer = true
    # Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
    # Bullet.stacktrace_excludes = [ 'their_gem', 'their_middleware' ]
    # Bullet.slack = { webhook_url: 'http://some.slack.url', channel: '#default', username: 'notifier' }
  end

  ##Online Excepetion
  Rails.application.config.middleware.use ExceptionNotification::Rack,
  :email => {
    :deliver_with => :deliver, # Rails >= 4.2.1 do not need this option since it defaults to :deliver_now
    :email_prefix => "[PREFIX] ",
    :sender_address => %{"notifier" <notifier@example.com>},
    :exception_recipients => %w{rahmatthea5@gmail.com}
  }
end
