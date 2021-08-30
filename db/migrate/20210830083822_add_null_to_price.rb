# frozen_string_literal: true

class AddNullToPrice < ActiveRecord::Migration[6.1]
  def change
    change_column :items, :price, :integer, null: false, default: 0
  end
end
