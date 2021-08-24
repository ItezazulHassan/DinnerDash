class Item < ApplicationRecord
  has_one_attached :avatar

  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories
  has_many :line_items, dependent: :destroy
  has_many :carts, through: :line_items

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :price, presence: true, numericality: true
  validates_associated :item_categories
end
