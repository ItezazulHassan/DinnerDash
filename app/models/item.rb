class Item < ApplicationRecord
    has_many :item_categories, dependent: :destroy
    has_many :categories, through: :item_categories
    has_many :line_items, dependent: :destroy
    has_many :carts, through: :line_items
    validates :name, presence: true, null: false, uniqueness: {case_sensitive: false}
    validates :description, presence: true, null: false
    validates :price, presence: true, numericality: true, greater_than: {0, message: 'Must be greate than 0'}
    validates_associated :item_categories
end
