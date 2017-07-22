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

ActiveRecord::Schema.define(version: 20160926232750) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "conversation_id"
    t.integer "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_comments_on_conversation_id"
    t.index ["created_at"], name: "index_comments_on_created_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conversations", id: :serial, force: :cascade do |t|
    t.integer "forum_id"
    t.integer "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_conversations_on_created_at"
    t.index ["forum_id"], name: "index_conversations_on_forum_id"
    t.index ["user_id"], name: "index_conversations_on_user_id"
  end

  create_table "faq_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faqs", id: :serial, force: :cascade do |t|
    t.integer "faq_category_id"
    t.integer "position", default: 0
    t.text "answer"
    t.text "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faq_category_id"], name: "index_faqs_on_faq_category_id"
  end

  create_table "feedback", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "manuscript_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manuscript_id"], name: "index_feedback_on_manuscript_id"
    t.index ["user_id"], name: "index_feedback_on_user_id"
  end

  create_table "forum_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forums", id: :serial, force: :cascade do |t|
    t.integer "forum_category_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forum_category_id"], name: "index_forums_on_forum_category_id"
  end

  create_table "friendship_statuses", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendships", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.integer "friendship_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["friendship_status_id"], name: "index_friendships_on_friendship_status_id"
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "genre_manuscripts", id: :serial, force: :cascade do |t|
    t.integer "genre_id"
    t.integer "manuscript_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_genre_manuscripts_on_genre_id"
    t.index ["manuscript_id"], name: "index_genre_manuscripts_on_manuscript_id"
  end

  create_table "genres", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inklings", id: :serial, force: :cascade do |t|
    t.integer "manuscript_id"
    t.boolean "hardcore"
    t.integer "revival_fee"
    t.string "revival_fee_currency"
    t.integer "word_count_goal"
    t.integer "word_rate_goal"
    t.integer "word_rate_goal_basis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manuscript_id"], name: "index_inklings_on_manuscript_id"
  end

  create_table "manuscripts", id: :serial, force: :cascade do |t|
    t.integer "rating_id"
    t.integer "user_id"
    t.integer "word_count"
    t.string "genre"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre"], name: "index_manuscripts_on_genre"
    t.index ["rating_id"], name: "index_manuscripts_on_rating_id"
    t.index ["user_id"], name: "index_manuscripts_on_user_id"
  end

  create_table "news_reports", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_news_reports_on_user_id"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "ratings", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", id: :serial, force: :cascade do |t|
    t.integer "manuscript_id"
    t.boolean "published"
    t.datetime "published_at"
    t.integer "position"
    t.integer "word_count"
    t.string "name"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manuscript_id"], name: "index_sections_on_manuscript_id"
  end

  create_table "user_roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.integer "user_role_id"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.datetime "reset_sent_at"
    t.string "activation_digest"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "reset_digest"
    t.string "simple_name"
    t.string "time_zone", default: ""
    t.string "username"
    t.text "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["simple_name"], name: "index_users_on_simple_name", unique: true
    t.index ["user_role_id"], name: "index_users_on_user_role_id"
  end

  create_table "word_counts", id: :serial, force: :cascade do |t|
    t.integer "manuscript_id"
    t.integer "user_id"
    t.datetime "completed_at"
    t.integer "words"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manuscript_id"], name: "index_word_counts_on_manuscript_id"
    t.index ["user_id"], name: "index_word_counts_on_user_id"
  end

end
