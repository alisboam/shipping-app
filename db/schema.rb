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

ActiveRecord::Schema[7.0].define(version: 2022_10_15_150814) do
  create_table "delivery_times", force: :cascade do |t|
    t.integer "distance_between"
    t.integer "hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "modality_id", null: false
    t.index ["modality_id"], name: "index_delivery_times_on_modality_id"
  end

  create_table "modalities", force: :cascade do |t|
    t.string "name"
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "min_weight"
    t.integer "max_weight"
    t.integer "status", default: 10
    t.integer "tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "sender_address"
    t.string "sender_name"
    t.string "receiver_address"
    t.integer "distance_between"
    t.string "product_code"
    t.integer "weight"
    t.integer "width"
    t.integer "height"
    t.string "receiver_name"
    t.string "code"
    t.integer "status", default: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "modality_id"
    t.integer "delivery_price"
    t.datetime "estimated_delivery_date"
    t.integer "vehicle_id"
    t.datetime "delivery_date"
    t.string "delay_reason"
    t.index ["modality_id"], name: "index_orders_on_modality_id"
    t.index ["vehicle_id"], name: "index_orders_on_vehicle_id"
  end

  create_table "prices_by_distances", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "modality_id", null: false
    t.index ["modality_id"], name: "index_prices_by_distances_on_modality_id"
  end

  create_table "prices_by_weights", force: :cascade do |t|
    t.integer "min_weight"
    t.integer "max_weight"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "modality_id", null: false
    t.index ["modality_id"], name: "index_prices_by_weights_on_modality_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate"
    t.string "brand"
    t.string "model"
    t.string "year"
    t.integer "capacity"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "modality_id", null: false
    t.index ["modality_id"], name: "index_vehicles_on_modality_id"
  end

  add_foreign_key "delivery_times", "modalities"
  add_foreign_key "orders", "modalities"
  add_foreign_key "orders", "vehicles"
  add_foreign_key "prices_by_distances", "modalities"
  add_foreign_key "prices_by_weights", "modalities"
  add_foreign_key "vehicles", "modalities"
end
