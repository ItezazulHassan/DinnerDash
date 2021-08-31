# frozen_string_literal: true

# Model for Cart
class Cart < ApplicationRecord
  attr_reader :cart_data

  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def sub_total
    line_items.sum(&:total_price)
  end

  def initialize(cart_data)
    @cart_data = cart_data || {}
  end

  def increment(item_id)
    @cart_data[item_id] ||= 0
    increment_cart_item_by_one(item_id)
  end

  def decrement(item_id)
    @cart_data[item_id] ||= 0
    if @cart_data[item_id] > 0
      @cart_data[item_id] -= 1
    elsif @cart_data[item_id] == 0
      delete
    end
  end

  def destroy
    @cart_data = nil
  end

  def delete
    @cart_data[item_id] = 0
  end

  private
    def increment_cart_item_by_one(item_id)
      @cart_data[item_id] += 1
    end
end
