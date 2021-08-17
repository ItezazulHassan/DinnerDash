class Item < ApplicationRecord
    has_many :item_categories
    has_many :categories, through: :item_categories
    has_many :line_items
    has_many :carts, through: :line_items
end
