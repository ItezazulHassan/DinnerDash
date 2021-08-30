# frozen_string_literal: true

class AddNullToStatus < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :status, :string, null: false
  end
end
