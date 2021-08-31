# frozen_string_literal: true

# Migration
class AddItemRefToItemCategories < ActiveRecord::Migration[6.1]
  def change
    add_reference :item_categories, :item, null: false, foreign_key: true
  end
end
