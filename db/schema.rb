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

ActiveRecord::Schema.define(version: 20130922172401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.integer  "from_id",                                  null: false
    t.integer  "to_id",                                    null: false
    t.string   "rel_type",   limit: 32, default: "FOLLOW", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["from_id", "to_id", "rel_type"], name: "index_relationships_on_from_id_and_to_id_and_rel_type", unique: true, using: :btree
  add_index "relationships", ["to_id"], name: "index_relationships_on_to_id", using: :btree

  create_table "talks", force: true do |t|
    t.string   "summary",     null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id",   null: false
  end

  add_index "talks", ["person_id", "created_at"], name: "index_talks_on_person_id_and_created_at", using: :btree

end
