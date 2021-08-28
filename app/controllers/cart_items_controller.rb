# frozen_string_literal: true

class CartItemsController < ApplicationController
  def create
    @cart.increment(params[:item_id])
    session[:cart] = @cart.cart_data
    redirect_to items_path
  end

  def destroy
    @cart.destroy
    session.delete(:cart)
  end

  def delete
    @cart.delete(:item_id)
  end

  def update
    cart = cart_params
    item_id = cart[:item_id]
    quantity = cart[:quantity]
    session[:cart][item_id] = quantity.to_i
    session[:order]['items'][item_id]['qty'] = quantity.to_i
    session[:order]['details'] = order_params
    render json: { data: item_id }
  end

  def update_quantity
    item_id = params[:item_id]
    quantity = params[:quantity].values[0].to_i
    session[:cart][item_id] = quantity.to_i
    session[:order]['items'][item_id]['qty'] = quantity.to_i
    session[:order]['details'] = order_params
    render json: { data: item_id }
  end

  private

  def cart_params
    params.require(:cart_items).permit(:item_id, :quantity)
  end

  def order_params
    params.require(:order_details).permit(:total)
  end
end
