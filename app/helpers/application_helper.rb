# frozen_string_literal: true

# Helper for Application
module ApplicationHelper
  def items_in_cart
    items = 0
    if !session[:cart].nil? && session[:cart].length.positive?
      session[:cart].each do |_key, value|
        items += value
      end
    end
    items
  end

  def this_item_in_cart(item)
    item_count = 0
    if !session.nil? && !session[:cart].nil?
      item_count = session[:cart][item.id.to_s].nil? ? 0 : session[:cart][item.id.to_s]
    end
  end

  def cart_properties
    cart_properties = {}
    if session[:cart].nil? || session[:cart].empty?
      cart_properties["items_count"] = 0
      cart_properties["status"] = "empty"
    else
      cart_properties["items_count"] = items_in_cart
      cart_properties["status"] = "not-empty"
    end
    cart_properties
  end

  def options_for_status
    %w[Completed Cancelled Pending]
  end

  def load_current_order
    @current_order = CurrentOrder.new(session[:order])
  end
end
