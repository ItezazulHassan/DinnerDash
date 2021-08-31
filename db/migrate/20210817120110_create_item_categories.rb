# frozen_string_literal: true

# Migration
class CreateItemCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :item_categories do |t|
      t.timestamps
    end
  end
end
