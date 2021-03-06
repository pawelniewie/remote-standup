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

ActiveRecord::Schema.define(version: 20140401191927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "authorizations", force: true do |t|
    t.text     "username"
    t.text     "provider"
    t.text     "uid"
    t.text     "token"
    t.text     "secret"
    t.uuid     "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "discussions", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.text     "title",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "team_id"
  end

  add_index "discussions", ["team_id"], name: "index_discussions_on_team_id", using: :btree

  create_table "notes", force: true do |t|
    t.text     "from_email",    default: "", null: false
    t.text     "from_name",     default: "", null: false
    t.text     "raw_payload",   default: "", null: false
    t.text     "message_text",  default: "", null: false
    t.text     "message_html",  default: "", null: false
    t.text     "note",          default: "", null: false
    t.uuid     "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "headers",       default: {}, null: false
    t.uuid     "team_id"
    t.text     "token",                      null: false
    t.uuid     "discussion_id"
  end

  add_index "notes", ["discussion_id"], name: "index_notes_on_discussion_id", using: :btree
  add_index "notes", ["team_id"], name: "index_notes_on_team_id", using: :btree
  add_index "notes", ["token"], name: "index_notes_on_token", unique: true, using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "teams", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.text     "name",       default: "Team", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.text     "email",                                             null: false
    t.text     "full_name",                        default: "",     null: false
    t.text     "calling_name",                     default: "",     null: false
    t.text     "picture",                          default: "",     null: false
    t.boolean  "male"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "timezone",                         default: "GMT",  null: false
    t.integer  "reminder_at_h",          limit: 2, default: 17,     null: false
    t.integer  "reminder_at_m",          limit: 2, default: 0,      null: false
    t.integer  "remind_on",              limit: 2,                  null: false, array: true
    t.datetime "sent_reminder_at"
    t.text     "encrypted_password",               default: ""
    t.text     "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text     "current_sign_in_ip"
    t.text     "last_sign_in_ip"
    t.text     "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.text     "unconfirmed_email"
    t.text     "provider"
    t.text     "uid"
    t.text     "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.uuid     "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",                default: 0
    t.uuid     "team_id"
    t.text     "type",                             default: "User", null: false
    t.datetime "sent_team_update_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["remind_on"], name: "index_users_on_remind_on", using: :gin
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree

end
