# frozen_string_literal: true

# Migration
class AddUserRefToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :user, null: false, foreign_key: true
  end
end
