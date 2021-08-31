# frozen_string_literal: true

class AddNullToTotal < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :total, :integer, null: false, default: 0
  end
end
