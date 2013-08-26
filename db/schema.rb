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

ActiveRecord::Schema.define(version: 20130826183518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: true do |t|
    t.integer  "person_id",       null: false
    t.string   "name",            null: false
    t.text     "description"
    t.string   "file_type"
    t.string   "pathname",        null: false
    t.string   "attachable_type", null: false
    t.string   "attachable_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["pathname"], name: "index_attachments_on_pathname", unique: true, using: :btree

  create_table "calendars", force: true do |t|
    t.integer  "person_id",                                   null: false
    t.string   "name"
    t.text     "description"
    t.datetime "time_point",  default: '2013-08-26 00:21:09', null: false
    t.string   "source",                                      null: false
    t.text     "settings"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maps", force: true do |t|
    t.integer  "person_id",               null: false
    t.string   "name"
    t.text     "description"
    t.integer  "location_id", default: 1, null: false
    t.text     "settings"
    t.string   "source",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "name",            null: false
    t.string   "email",           null: false
    t.text     "about_me"
    t.string   "screen_name"
    t.string   "settings"
    t.string   "person_type"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true, using: :btree

  create_table "posts", force: true do |t|
    t.integer  "person_id",  null: false
    t.integer  "talk_id",    null: false
    t.string   "post_type",  null: false
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "tagable_type",              null: false
    t.string   "tagable_id",                null: false
    t.string   "tag_type",     default: "", null: false
    t.string   "tag",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "talks", force: true do |t|
    t.string   "summary",     null: false
    t.text     "description"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.integer  "person_id"
    t.integer  "post_id"
    t.string   "screen_name"
    t.string   "content",     null: false
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
