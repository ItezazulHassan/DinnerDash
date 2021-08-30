# frozen_string_literal: true

# Model for Item Category
class ItemCategory < ApplicationRecord
  belongs_to :item
  belongs_to :category
  validates :item_id, presence: true
  validates :category_id, presence: true
end
