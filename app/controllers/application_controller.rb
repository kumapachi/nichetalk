class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  # フレンドリフォワーディング機能
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!, except: [:show, :index]

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
  end
  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end
end
