class AddPictureToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :picture, :string
  end
end
