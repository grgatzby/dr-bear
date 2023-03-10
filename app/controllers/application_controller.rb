class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  # work in progress : choeckin to the basket page
  # protect_from_forgery with: :exception
  # before_action :set_redirect_path, unless: :user_signed_in?
  # def set_redirect_path
  #   @redirect_path = request.path
  # end

  # # Determine where to redirect user after successful login.
  # def after_sign_in_path_for(resource)
  #   if request.referer == set_redirect_path
  #     super
  #   else
  #     stored_location_for(resource) || request.referer || root_path
  #   end
  # end

end
