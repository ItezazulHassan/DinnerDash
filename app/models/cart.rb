class Cart < ApplicationRecord
    attr_reader :cart_data
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
    
	def initialize(cart_data)
    @cart_data = cart_data || {}
	end

	def increment(item_id)
	  @cart_data[item_id] ||= 0
	  increment_cart_item_by_one(item_id)
	end

	def destroy
	  @cart_data = nil
	end

	def delete
		@cart_data[item_id] = 0
	end

	private

	def increment_cart_item_by_one(item_id)
	  @cart_data[item_id] += 1
	end
end
