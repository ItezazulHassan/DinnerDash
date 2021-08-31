# frozen_string_literal: true

# Migration
class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.timestamps
    end
  end
end
