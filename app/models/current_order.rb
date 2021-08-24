class CurrentOrder < ApplicationRecord
    attr_accessor :line_items
    attr_accessor :total

    def initialize(current_order)
        @line_items = current_order["items"] || {}
        current_order["details"] ||= {}
        @total = current_order["details"]["total"].to_i || 0
        @user = {}
        @status = "pending"
    end

    def update_order(order, args)
        @line_items = order["items"] || {}
        @total = order["details"]["total"] || 0
        @status = args[:status] || "pending"
    end

    def save_order(current_user)
        user = current_user
        new_order = user.orders.new(total: @total)
        save_successful = new_order.save
        if save_successful
            @line_items.each do |index, details|
                new_order.order_items <<
                OrderItem.create(item_id: details["item"]["id"],
                                quantity: details["qty"])
            end
        end
        save_successful
    end

    def delete

    end
end
