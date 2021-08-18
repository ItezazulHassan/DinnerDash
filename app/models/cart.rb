class Cart < ApplicationRecord
    belongs_to :user
    has_many :line_items
    has_many :items, through: :line_items
    
    def sub_total
        sum=0
        line_items.each do |item|
            sum += item.total_price
        end
        sum
    end
end
