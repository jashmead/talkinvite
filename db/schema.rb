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

ActiveRecord::Schema.define(version: 20131111181942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "person_id"
    t.integer  "talk_id"
    t.text     "comment_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["person_id", "talk_id"], name: "index_comments_on_person_id_and_talk_id", unique: true, using: :btree

  create_table "credits", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credits", ["name"], name: "index_credits_on_name", unique: true, using: :btree

  create_table "faqs", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "faqs", ["question"], name: "index_faqs_on_question", unique: true, using: :btree

  create_table "helps", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "helps", ["name"], name: "index_helps_on_name", unique: true, using: :btree

  create_table "maps", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.text     "geometry",    default: "{}"
    t.text     "settings",    default: "{}"
    t.text     "history",     default: "{}"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.integer  "talk_id"
    t.integer  "person_id"
    t.string   "rsvp_status", default: "accepted", null: false
    t.string   "member_type", default: "member",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["person_id", "talk_id"], name: "index_members_on_person_id_and_talk_id", unique: true, using: :btree

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "message_type", default: "email"
    t.text     "message_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "name",                            null: false
    t.string   "email",                           null: false
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.boolean  "admin",           default: false, null: false
    t.boolean  "sub",             default: false, null: false
    t.text     "description"
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true, using: :btree
  add_index "people", ["remember_token"], name: "index_people_on_remember_token", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "person_id",                            null: false
    t.integer  "talk_id",                              null: false
    t.string   "service_type",  default: "talkinvite", null: false
    t.text     "service_notes"
    t.string   "post_type",     default: "start",      null: false
    t.text     "post_message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.integer  "person_id"
    t.string   "service_type",  default: "talkinvite"
    t.text     "service_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "talks", force: true do |t|
    t.string   "summary",                     null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id",                   null: false
    t.datetime "start_dt"
    t.datetime "end_dt"
    t.datetime "posted_dt"
    t.decimal  "longitude"
    t.decimal  "latitude"
    t.string   "who_desc"
    t.string   "talk_status", default: "new"
    t.string   "where_desc"
    t.string   "when_desc"
  end

  add_index "talks", ["person_id", "created_at"], name: "index_talks_on_person_id_and_created_at", using: :btree

end
