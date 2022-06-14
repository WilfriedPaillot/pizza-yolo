class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :danger, :info, :warning, :success, :messages
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # Devise overrides
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update, 
      keys: [
        :firstname, 
        :lastname, 
        :email, 
        :password, 
        :password_confirmation, 
        :current_password,
        :firstname,
        :lastname,
        :address,
        :zipcode,
        :city,
        :phone
      ]
    )
  end
end
