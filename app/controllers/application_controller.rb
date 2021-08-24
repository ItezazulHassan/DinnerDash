class ApplicationController < ActionController::Base
  include Pundit
  
  def set_theme
    @current_theme ||= 'full'
  end

  def load_cart
    @cart ||= Cart.new(session[:cart])
  end

  def load_current_order
    session[:order] ||= {}
    # @current_order ||= CurrentOrder.new(session[:order])
    @current_order ||= {}
    # @current_order = CurrentOrder.new(session[:order])
    # @current_order = Order.new
  end

  attr_reader :cart

  before_action :set_theme
  before_action :load_cart
  before_action :current_user
  before_action :load_current_order
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :cart
  helper_method :current_order

  protected

  def configure_permitted_parameters
    attributes = %i[name username email encrypted_password password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
end
