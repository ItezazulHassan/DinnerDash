class RemoveNullFromLineItems < ActiveRecord::Migration[6.1]
  def change
    change_column_null :line_items, :cart_id, true
  end
end
