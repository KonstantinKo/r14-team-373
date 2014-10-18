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

ActiveRecord::Schema.define(version: 20141018091402) do

  create_table "comments", force: true do |t|
    t.integer  "treasure_id"
    t.string   "email"
    t.text     "content"
    t.boolean  "notify"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "snippets", force: true do |t|
    t.string   "snippetable_type"
    t.integer  "snippetable_id"
    t.string   "link"
    t.text     "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treasures", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
  end

end
