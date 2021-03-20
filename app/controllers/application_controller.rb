class ApplicationController < ActionController::Base
    include ApplicationHelper
    add_flash_types :success, :info, :warning, :danger
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    def configure_permitted_parameters
        added_attrs = [ :email, :name, :display_name, :description, :icon, :url, :password, :password_confirmation ]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
        devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    end
end
