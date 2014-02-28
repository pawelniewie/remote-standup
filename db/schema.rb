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

ActiveRecord::Schema.define(version: 20140228202647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.text     "email",                                          null: false
    t.text     "full_name",                      default: "",    null: false
    t.text     "calling_name",                   default: "",    null: false
    t.text     "picture",                        default: "",    null: false
    t.text     "google_token",                   default: "",    null: false
    t.datetime "google_token_expires"
    t.boolean  "male"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "timezone",                       default: "GMT", null: false
    t.integer  "reminder_at_h",        limit: 2, default: 17,    null: false
    t.integer  "reminder_at_m",        limit: 2, default: 0,     null: false
    t.text     "remind_on",                      default: "1-5", null: false
    t.text     "members",                        default: [],    null: false, array: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
