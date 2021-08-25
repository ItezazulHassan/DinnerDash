class CurrentOrder
  attr_accessor :line_items, :total

  def initialize(current_order)
    @line_items = current_order['items'] || {}
    current_order['details'] ||= {}
    @total = current_order['details']['total'].to_i || 0
    @user = {}
    @status = 'pending'
  end

  def update_order(order, args)
    @line_items = order['items'] || {}
    @total = order['details']['total'] || 0
    @status = args[:status] || 'pending'
  end

  def save_order(current_user)
    user = current_user
    new_order = user.orders.new(status: @status, total: @total)
    save_successful = new_order.save
    if save_successful
      @line_items.each do |_index, details|
        # byebug
        # new_order.line_items <<
        #  LineItem.create(item_id: details['item']['id'],
        #                  quantity: details['qty'], order_id: new_order.id)
        @line_item = LineItem.new(item_id: details['item']['id'], quantity: details['qty'], order_id: new_order.id)
        @line_item.save
        new_order.line_items.push(@line_item)
      end
    end
    save_successful
  end

  def delete; end
end
