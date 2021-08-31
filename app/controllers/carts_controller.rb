# frozen_string_literal: true

# Controller for cart
class CartsController < ApplicationController
  def index
    @cart_items = session[:cart]
    @ordered_items = {}
    @total = 0
    unless session[:cart].nil?
      @cart_items.each do |item_id, qty|
        item = Item.find_by(id: item_id)
        @ordered_items[item_id] = { item: item, qty: qty }
        check_status(item, qty, item_id)
      end
    end
    # @current_order.line_items = @ordered_items
    session[:order]["items"] = @ordered_items
  end

  def destroy
    item_id = params[:id]
    @cart.cart_data.delete(item_id)
    redirect_to carts_path
  end

  def check_status(item, qty, item_id)
    if item.flag == true
      @total += qty * item.price
    else
      @ordered_items.delete(item_id)
    end
  end
end
