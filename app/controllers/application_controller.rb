class ApplicationController < ActionController::Base
    include ApplicationHelper
    add_flash_types :success, :info, :warning, :danger
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
        user_goals_path
    end

    protected
    def configure_permitted_parameters
        added_attrs = [ :email, :name, :display_name, :description, :icon, :url, :password, :password_confirmation ]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
        devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    end
end
