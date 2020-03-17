# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_17_162402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "areas", force: :cascade do |t|
    t.bigint "sitter_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sitter_id"], name: "index_areas_on_sitter_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "sitter_id"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_bookings_on_customer_id"
    t.index ["sitter_id"], name: "index_bookings_on_sitter_id"
  end

  create_table "contact_infos", force: :cascade do |t|
    t.string "street"
    t.string "post_code"
    t.string "city"
    t.string "country"
    t.string "phone"
    t.text "bio"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_availabilities", force: :cascade do |t|
    t.bigint "customer_id"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_availabilities_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.bigint "contact_infos_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["contact_infos_id"], name: "index_customers_on_contact_infos_id"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "kids", force: :cascade do |t|
    t.bigint "customer_id"
    t.integer "age"
    t.string "first_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_kids_on_customer_id"
  end

  create_table "sitter_availabilities", force: :cascade do |t|
    t.bigint "sitter_id"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sitter_id"], name: "index_sitter_availabilities_on_sitter_id"
  end

  create_table "sitters", force: :cascade do |t|
    t.integer "age"
    t.bigint "contact_infos_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["contact_infos_id"], name: "index_sitters_on_contact_infos_id"
    t.index ["email"], name: "index_sitters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_sitters_on_reset_password_token", unique: true
  end

  add_foreign_key "areas", "sitters"
  add_foreign_key "bookings", "customers"
  add_foreign_key "bookings", "sitters"
  add_foreign_key "customer_availabilities", "customers"
  add_foreign_key "customers", "contact_infos", column: "contact_infos_id"
  add_foreign_key "kids", "customers"
  add_foreign_key "sitter_availabilities", "sitters"
  add_foreign_key "sitters", "contact_infos", column: "contact_infos_id"
end
