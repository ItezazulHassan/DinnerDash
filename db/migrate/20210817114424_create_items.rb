class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false, unique: true
      t.text :description, null: false
      t.integer :price
      t.boolean :flag, default: true
      t.timestamps
    end
  end
end
