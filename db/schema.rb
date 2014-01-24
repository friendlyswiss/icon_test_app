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

ActiveRecord::Schema.define(version: 20140124024540) do

  create_table "sessions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "test_browser"
    t.string   "test_os"
    t.string   "test_device"
    t.string   "age"
    t.string   "primary_os"
    t.integer  "years_exp"
    t.float    "success_rate"
    t.string   "primary_mobile"
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
  end

end
