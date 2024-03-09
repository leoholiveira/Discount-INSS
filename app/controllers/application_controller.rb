# frozen_string_literal: true

# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up)
  end

  def after_sign_in_path_for(_resource)
    proponents_path
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    err_message = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
    render json: { message: err_message }, status: :unauthorized
  end
end
