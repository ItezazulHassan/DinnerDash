class AddCategoryRefToItemCategories < ActiveRecord::Migration[6.1]
  def change
    add_reference :item_categories, :category, null: false, foreign_key: true
  end
end
