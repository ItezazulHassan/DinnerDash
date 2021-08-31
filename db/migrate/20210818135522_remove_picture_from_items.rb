# frozen_string_literal: true

# Migration
class RemovePictureFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :picture, :string
  end
end
