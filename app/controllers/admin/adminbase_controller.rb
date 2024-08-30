class Admin::AdminbaseController < ApplicationController
  layout 'admin' 
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, :alert => exception.message
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role_id, :name])
  end

  #derive the model name from the controller. egs UsersController will return User
  def self.permission
    return name = self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
  end
end
