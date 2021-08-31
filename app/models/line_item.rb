# frozen_string_literal: true

# Model for Line Item
class LineItem < ApplicationRecord
  # belongs_to :cart
  belongs_to :item
  belongs_to :order
  validates :item_id, presence: true

  def total_price
    if valid_quantity_and_price?
      quantity.to_s.to_d * item.price.to_s.to_d
    else
      0
    end
  end

  def valid_quantity_and_price
    !quantity.to_s.strip.empty? && !item.price.to_s.strip.empty?
  end
end
