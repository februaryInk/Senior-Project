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

ActiveRecord::Schema.define(version: 20141222005502) do

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["conversation_id"], name: "index_comments_on_conversation_id"
  add_index "comments", ["created_at"], name: "index_comments_on_created_at"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "conversations", force: true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["created_at"], name: "index_conversations_on_created_at"
  add_index "conversations", ["forum_id"], name: "index_conversations_on_forum_id"
  add_index "conversations", ["user_id"], name: "index_conversations_on_user_id"

  create_table "forums", force: true do |t|
    t.string   "group"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_reports", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news_reports", ["user_id"], name: "index_news_reports_on_user_id"

  create_table "users", force: true do |t|
    t.boolean  "admin",           default: false
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "simple_name"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["simple_name"], name: "index_users_on_simple_name", unique: true

end
