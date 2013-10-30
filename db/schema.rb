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

ActiveRecord::Schema.define(version: 20131029224735) do

  create_table "booklists", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "booklists_books", id: false, force: true do |t|
    t.integer "book_id",     null: false
    t.integer "booklist_id", null: false
  end

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "author"
    t.text     "description"
    t.string   "picture"
    t.date     "publication"
    t.float    "rating_style"
    t.float    "rating_plot"
    t.float    "rating_theme"
    t.float    "rating_characters"
    t.float    "rating_overall"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank"
  end

  create_table "comment2s", force: true do |t|
    t.text     "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "comment_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "title",      limit: 255
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "topic_id"
  end

  add_index "comments", ["topic_id"], name: "index_comments_on_topic_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "ratings", force: true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.float    "rating_style"
    t.float    "rating_plot"
    t.float    "rating_theme"
    t.float    "rating_characters"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggested_books", force: true do |t|
    t.string   "title"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "book_id"
  end

  add_index "suggested_books", ["book_id"], name: "index_suggested_books_on_book_id"

  create_table "topics", force: true do |t|
    t.string   "title"
    t.string   "category"
    t.text     "description"
    t.integer  "votes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "book_id"
    t.integer  "user_id"
  end

  add_index "topics", ["book_id"], name: "index_topics_on_book_id"
  add_index "topics", ["user_id"], name: "index_topics_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votetps", force: true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.string   "up_or_down"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
