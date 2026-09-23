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

ActiveRecord::Schema[8.1].define(version: 2026_09_22_220902) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.string "city"
    t.datetime "created_at", null: false
    t.date "end_date"
    t.date "start_date"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "vehicle_id", null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
    t.index ["vehicle_id"], name: "index_bookings_on_vehicle_id"
  end

  create_table "exo_active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_exo_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_exo_active_storage_attachments_uniqueness", unique: true
  end

  create_table "exo_active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_exo_active_storage_blobs_on_key", unique: true
  end

  create_table "exo_active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_exo_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "exo_cars_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_exo_cars_users_on_email", unique: true
    t.index ["name"], name: "index_exo_cars_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_exo_cars_users_on_reset_password_token", unique: true
  end

  create_table "galleries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id", null: false
    t.index ["vehicle_id"], name: "index_galleries_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "acceleration"
    t.string "brand"
    t.string "color"
    t.string "country"
    t.datetime "created_at", null: false
    t.string "description"
    t.string "max_speed"
    t.string "model"
    t.string "power"
    t.integer "price"
    t.datetime "updated_at", null: false
    t.string "year"
  end

  add_foreign_key "bookings", "exo_cars_users", column: "user_id"
  add_foreign_key "bookings", "vehicles"
  add_foreign_key "exo_active_storage_attachments", "exo_active_storage_blobs", column: "blob_id"
  add_foreign_key "exo_active_storage_variant_records", "exo_active_storage_blobs", column: "blob_id"
  add_foreign_key "galleries", "vehicles"
end
