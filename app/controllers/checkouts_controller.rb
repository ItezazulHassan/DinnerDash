class CheckoutsController < ApplicationController
    def show
        if logged_in?
            @current_order.line_items = session[:order]["items"]
        else
            redirect_to login_path
        end
    end

    def create
        if order_params[:status].downcase === "completed"
            @current_order.update_order(session[:order], order_params)
            if @current_order.save_order(@current_user)
              session[:order] = {}
              session[:cart] = {}
              flash[:success] = "Your order has been successfully placed."
              redirect_to root_path
            else
              flash[:error] = "An error occured while saving your order. Please try again."
              redirect_to cart_checkout_path
            end
        end
    end

    private

    def order_params
        {:status => params[:status]}
    end
end
