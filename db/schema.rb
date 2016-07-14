# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141014013812) do

  create_table "bids", force: true do |t|
    t.string   "vendor"
    t.string   "customer"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "total_cost"
    t.string   "attachment"
    t.string   "type"
    t.boolean  "imported",    default: false
    t.boolean  "uploaded",    default: false
  end

  add_index "bids", ["property_id"], name: "index_bids_on_property_id"

  create_table "credentials", force: true do |t|
    t.string   "user"
    t.string   "password"
    t.string   "token"
    t.string   "cookie"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ASPToken"
  end

  create_table "items", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bidRoomId"
    t.integer  "itemCcId"
    t.integer  "itemCount"
    t.integer  "reasonId"
    t.integer  "itemCost"
    t.integer  "regionId"
    t.integer  "itemClassId"
    t.boolean  "analystAdded"
    t.string   "uom"
    t.string   "description"
  end

  create_table "manifests", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bid_id"
    t.integer  "item_id"
    t.string   "room"
    t.integer  "room_id"
    t.integer  "reason"
    t.integer  "quantity"
    t.string   "description"
    t.decimal  "unit_cost"
    t.decimal  "total_cost"
  end

  create_table "mycurls", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "sq_ft"
    t.integer  "beds"
    t.decimal  "baths"
    t.integer  "portal_request_id"
    t.string   "property_id"
    t.boolean  "import_completed",         default: false
    t.string   "status"
    t.boolean  "imported"
    t.integer  "contractor"
  end

  create_table "rooms", force: true do |t|
    t.integer  "bidRoomId"
    t.integer  "bidRequestId"
    t.integer  "roomTypeId"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "rooms", ["property_id"], name: "index_rooms_on_property_id"

  create_table "trigrams", force: true do |t|
    t.string  "trigram",     limit: 3
    t.integer "score",       limit: 2
    t.integer "owner_id"
    t.string  "owner_type"
    t.string  "fuzzy_field"
  end

  add_index "trigrams", ["owner_id", "owner_type", "fuzzy_field", "trigram", "score"], name: "index_for_match"
  add_index "trigrams", ["owner_id", "owner_type"], name: "index_by_owner"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
