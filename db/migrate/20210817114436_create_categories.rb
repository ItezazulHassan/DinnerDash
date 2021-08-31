# frozen_string_literal: true

# Migration
class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false, unique: true
      t.timestamps
    end
  end
end
