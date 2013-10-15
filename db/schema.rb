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

ActiveRecord::Schema.define(version: 20131015223919) do

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

  create_table "members", force: true do |t|
    t.integer  "talk_id"
    t.integer  "person_id"
    t.string   "rsvp_status", default: "accepted", null: false
    t.string   "member_type", default: "member",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["person_id", "talk_id"], name: "index_members_on_person_id_and_talk_id", unique: true, using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "person_id"
    t.integer  "talk_id"
    t.string   "note_type",  default: "announce"
    t.text     "note_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["person_id", "talk_id"], name: "index_notifications_on_person_id_and_talk_id", unique: true, using: :btree

  create_table "people", force: true do |t|
    t.string   "name",                            null: false
    t.string   "email",                           null: false
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.boolean  "admin",           default: false, null: false
    t.boolean  "sub",             default: false, null: false
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true, using: :btree
  add_index "people", ["remember_token"], name: "index_people_on_remember_token", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "socials", force: true do |t|
    t.integer  "person_id",                      null: false
    t.integer  "talk_id",                        null: false
    t.string   "social_type", default: "invite", null: false
    t.text     "social_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "socials", ["person_id", "talk_id"], name: "index_socials_on_person_id_and_talk_id", unique: true, using: :btree

  create_table "talks", force: true do |t|
    t.string   "summary",     null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id",   null: false
    t.integer  "venue_id"
  end

  add_index "talks", ["person_id", "created_at"], name: "index_talks_on_person_id_and_created_at", using: :btree
  add_index "talks", ["venue_id"], name: "index_talks_on_venue_id", using: :btree

  create_table "venues", force: true do |t|
    t.string   "venue_type",  default: "venue"
    t.integer  "person_id"
    t.string   "name"
    t.text     "description"
    t.decimal  "longitude"
    t.decimal  "latitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
