class Cart < ApplicationRecord
    belongs_to :user
    has_many :line_items
    has_many :items, through: :line_items
    
    def sub_total
        line_items.sum(&:total_price)
    end
end
