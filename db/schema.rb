# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_830_084_504) do
  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.integer 'record_id', null: false
    t.integer 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.integer 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'carts', force: :cascade do |t|
    t.integer 'total', default: 0
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'user_id', null: false
    t.index ['user_id'], name: 'index_carts_on_user_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'item_categories', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'item_id', null: false
    t.integer 'category_id', null: false
    t.index ['category_id'], name: 'index_item_categories_on_category_id'
    t.index ['item_id'], name: 'index_item_categories_on_item_id'
  end

  create_table 'items', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'description', null: false
    t.integer 'price', default: 0, null: false
    t.boolean 'flag', default: true
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'line_items', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'item_id', null: false
    t.integer 'cart_id'
    t.integer 'quantity', default: 1, null: false
    t.integer 'order_id', null: false
    t.index ['cart_id'], name: 'index_line_items_on_cart_id'
    t.index ['item_id'], name: 'index_line_items_on_item_id'
    t.index ['order_id'], name: 'index_line_items_on_order_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.string 'status', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'user_id', null: false
    t.integer 'total', default: 0, null: false
    t.index ['user_id'], name: 'index_orders_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'username'
    t.boolean 'flag', default: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'carts', 'users'
  add_foreign_key 'item_categories', 'categories'
  add_foreign_key 'item_categories', 'items'
  add_foreign_key 'line_items', 'carts'
  add_foreign_key 'line_items', 'items'
  add_foreign_key 'line_items', 'orders'
  add_foreign_key 'orders', 'users'
end
