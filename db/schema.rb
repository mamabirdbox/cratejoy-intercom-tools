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

ActiveRecord::Schema.define(version: 20160315200436) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boxes", force: :cascade do |t|
    t.string   "name"
    t.integer  "position",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "boxes", ["position"], name: "index_boxes_on_position", unique: true, using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "intercom_status", default: "unchecked"
    t.string   "intercom_id"
    t.integer  "cratejoy_id"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "tracking_number"
    t.integer  "cratejoy_id",         null: false
    t.integer  "box_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "customer_id"
    t.date     "shipment_created_at"
  end

  add_index "orders", ["box_id"], name: "index_orders_on_box_id", using: :btree
  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree

  add_foreign_key "orders", "boxes"
end
