# frozen_string_literal: true

# Migration
class RemoveEmailFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :email, :string
  end
end
