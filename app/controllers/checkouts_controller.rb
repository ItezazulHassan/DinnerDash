# frozen_string_literal: true

# Controller for checkout
class CheckoutsController < ApplicationController
  def show
    if user_signed_in?
      # @current_order.line_items = session[:order]["items"]
      render "checkout/show"
    else
      redirect_to new_user_session_path
    end
  end

  def create
    # byebug
    # if order_params[:status] === 'completed'
    @current_order.update_order(session[:order], order_params)
    # byebug
    if @current_order.save_order(@current_user)
      session[:order] = {}
      session[:cart] = {}
      flash[:success] = "Your order has been successfully placed."
      redirect_to root_path
    else
      flash[:error] = "An error occured while saving your order. Please try again."
      redirect_to cart_checkout_path
    end
    # end
  end

  private
    def order_params
      { status: params[:status] }
    end
end
