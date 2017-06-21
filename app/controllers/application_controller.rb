class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def after_sign_in_path_for(resources)
    products_url
  end
  # => protect_from_forgery
end
