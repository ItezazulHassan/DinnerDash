# frozen_string_literal: true

# Migration
class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.timestamps
    end
  end
end
