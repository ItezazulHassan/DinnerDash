# frozen_string_literal: true

class AddNullToQuantity < ActiveRecord::Migration[6.1]
  def change
    change_column :line_items, :quantity, :integer, null: false, default: 1
  end
end
