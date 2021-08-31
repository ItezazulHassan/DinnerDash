# frozen_string_literal: true

# Model for Category
class Category < ApplicationRecord
  has_many :item_categories, dependent: :destroy
  has_many :items, through: :item_categories
  validates :name, presence: true, uniqueness: true
end
