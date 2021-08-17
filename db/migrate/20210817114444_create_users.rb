class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :username
      t.string :email, null: false, unique: true
      t.string :password
      t.boolean :flag, default: false
      t.timestamps
    end
  end
end
