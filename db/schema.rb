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

ActiveRecord::Schema.define(version: 20140211052504) do

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "sessions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "test_browser"
    t.string   "test_os"
    t.string   "age"
    t.string   "primary_os"
    t.float    "success_rate"
    t.string   "primary_mobile"
    t.string   "random_id"
    t.float    "success_rate_normalized"
  end

  create_table "trials", force: true do |t|
    t.integer  "sequence_order"
    t.string   "target_form"
    t.string   "style"
    t.string   "color"
    t.boolean  "task_success"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_id"
    t.integer  "task_time"
    t.string   "random_id"
  end

end
