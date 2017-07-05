source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'jquery-rails'

#Image Editor & Uploder
gem 'carrierwave', '~> 0.8.0'
gem 'mini_magick'
gem 'carrierwave-crop'


gem 'devise'
gem 'bcrypt', '~> 3.1.7'


gem 'twitter-bootstrap-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'bootstrap-sass-extras'
gem 'simple_form'

gem 'slim-rails', '3.1.1'
gem "cocoon"
gem "mail"
gem "figaro"
#gem 'mailgun_rails'
gem 'kaminari'
gem 'ckeditor'
gem 'activeadmin', github: 'activeadmin'
gem 'active_skin'
gem 'cancancan'
gem 'html2slim'
gem 'mailgun-ruby', '~>1.1.6'
gem 'activemerchant'


#OmniAuth
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'


#SLug
gem 'friendly_id' # Note: You MUST use 5.0.0 or greater for Rails 4.0+


#Money Exchanger
gem 'money'

#Cloudinary
gem 'cloudinary'

#Searh gem
gem 'elasticsearch'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'searchkick'

#exception
gem 'exception_notification'

#sidekiq
gem 'sidekiq'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'binding_of_caller'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
  gem 'better_errors' #gem "binding_of_caller" More Advance
  gem 'pry-rails'
  gem 'letter_opener'
  gem 'rack-mini-profiler'
  # For memory profiling (requires Ruby MRI 2.1+)
  gem 'memory_profiler'
  # For call-stack profiling flamegraphs (requires Ruby MRI 2.0.0+)
  gem 'flamegraph'
  gem 'stackprof'     # For Ruby MRI 2.1+
  gem 'fast_stack'    # For Ruby MRI 2.0
  gem 'rubycritic'
  gem 'ruby_gntp'
  gem 'ruby-growl'
  gem 'xmpp4r' # xmp notifier
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
