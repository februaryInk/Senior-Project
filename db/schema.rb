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

ActiveRecord::Schema.define(version: 20150125224207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["conversation_id"], name: "index_comments_on_conversation_id", using: :btree
  add_index "comments", ["created_at"], name: "index_comments_on_created_at", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["created_at"], name: "index_conversations_on_created_at", using: :btree
  add_index "conversations", ["forum_id"], name: "index_conversations_on_forum_id", using: :btree
  add_index "conversations", ["user_id"], name: "index_conversations_on_user_id", using: :btree

  create_table "forums", force: :cascade do |t|
    t.string   "group"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
  add_index "friendships", ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true, using: :btree
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id", using: :btree

  create_table "inkling_part_guides", force: :cascade do |t|
    t.string  "kind"
    t.integer "max_points"
    t.integer "max_might_points"
    t.integer "max_light_points"
    t.integer "max_dark_points"
  end

  create_table "inkling_parts", force: :cascade do |t|
    t.integer  "inkling_id"
    t.integer  "inkling_part_guide_id"
    t.string   "selector"
    t.string   "kind"
    t.integer  "total_points"
    t.integer  "might_points"
    t.integer  "light_points"
    t.integer  "dark_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inklings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "manuscript_id"
    t.integer  "word_count_goal"
    t.integer  "word_rate_goal"
    t.integer  "word_rate_goal_basis"
    t.integer  "revival_fee"
    t.integer  "revival_fee_currency"
    t.boolean  "hardcore"
    t.integer  "points"
    t.integer  "might_points"
    t.integer  "light_points"
    t.integer  "dark_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inklings", ["manuscript_id"], name: "index_inklings_on_manuscript_id", using: :btree
  add_index "inklings", ["user_id"], name: "index_inklings_on_user_id", using: :btree

  create_table "manuscripts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "genre"
    t.text     "description"
    t.integer  "word_count"
    t.integer  "might_word_count"
    t.integer  "light_word_count"
    t.integer  "dark_word_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "manuscripts", ["genre"], name: "index_manuscripts_on_genre", using: :btree
  add_index "manuscripts", ["user_id"], name: "index_manuscripts_on_user_id", using: :btree

  create_table "news_reports", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news_reports", ["user_id"], name: "index_news_reports_on_user_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "manuscript_id"
    t.integer  "position"
    t.string   "name"
    t.text     "content"
    t.integer  "word_count"
    t.integer  "might_word_count"
    t.integer  "light_word_count"
    t.integer  "dark_word_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["manuscript_id"], name: "index_sections_on_manuscript_id", using: :btree
  add_index "sections", ["user_id"], name: "index_sections_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.boolean  "admin",           default: false
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "simple_name"
    t.string   "username"
    t.text     "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["simple_name"], name: "index_users_on_simple_name", unique: true, using: :btree

end
