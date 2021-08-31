# frozen_string_literal: true

# Migration
class AddTotalToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :total, :integer
  end
end
