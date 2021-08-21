class ApplicationController < ActionController::Base
    include Pundit
    def set_theme
        @current_theme ||= "full"
    end

    def load_cart
        @cart ||= Cart.new(session[:cart])
    end

    def load_current_order
        session[:order] ||= {}
        @current_order ||= Current_Order.new(session[:order])
    end

    def cart
        @cart
    end

    before_action :set_theme
    before_action :load_cart
    before_action :current_user
    before_action :load_current_order

    helper_method :cart
    helper_method :current_order
end
