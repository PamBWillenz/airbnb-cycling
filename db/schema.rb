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

ActiveRecord::Schema.define(version: 20170829190431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "available_dates", force: :cascade do |t|
    t.date     "available_date"
    t.integer  "location_id"
    t.boolean  "booked",         default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["location_id"], name: "index_available_dates_on_location_id", using: :btree
  end

  create_table "location_images", force: :cascade do |t|
    t.string   "caption"
    t.integer  "picture_order"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "location_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["location_id"], name: "index_location_images_on_location_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "postcode"
    t.string   "bike_type"
    t.integer  "guests"
    t.integer  "member_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["member_id"], name: "index_locations_on_member_id", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "stripe_access_token"
    t.string   "stripe_refresh_token"
    t.string   "stripe_publishable_key"
    t.string   "stripe_user_id"
    t.string   "provider"
    t.index ["email"], name: "index_members_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true, using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.text     "bio"
    t.integer  "member_id"
    t.string   "name"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "profile_pic_file_name"
    t.string   "profile_pic_content_type"
    t.integer  "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
    t.index ["member_id"], name: "index_profiles_on_member_id", using: :btree
  end

  create_table "reservations", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "location_id"
    t.integer  "member_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["location_id"], name: "index_reservations_on_location_id", using: :btree
    t.index ["member_id"], name: "index_reservations_on_member_id", using: :btree
  end

  add_foreign_key "available_dates", "locations"
  add_foreign_key "location_images", "locations"
  add_foreign_key "locations", "members"
  add_foreign_key "profiles", "members"
  add_foreign_key "reservations", "locations"
  add_foreign_key "reservations", "members"
end
