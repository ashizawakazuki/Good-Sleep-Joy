# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_03_11_120249) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diaries", force: :cascade do |t|
    t.datetime "date"
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.text "content", null: false
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "habit_comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "habit_post_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_post_id"], name: "index_habit_comments_on_habit_post_id"
    t.index ["user_id"], name: "index_habit_comments_on_user_id"
  end

  create_table "habit_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "habit_post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_post_id"], name: "index_habit_likes_on_habit_post_id"
    t.index ["user_id"], name: "index_habit_likes_on_user_id"
  end

  create_table "habit_posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "habit_post_image"
    t.index ["user_id"], name: "index_habit_posts_on_user_id"
  end

  create_table "item_comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "item_post_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_post_id"], name: "index_item_comments_on_item_post_id"
    t.index ["user_id"], name: "index_item_comments_on_user_id"
  end

  create_table "item_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_post_id"], name: "index_item_likes_on_item_post_id"
    t.index ["user_id"], name: "index_item_likes_on_user_id"
  end

  create_table "item_posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item_post_image"
    t.index ["user_id"], name: "index_item_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "avatar"
    t.time "wake_up_time"
    t.time "bed_time"
    t.time "sleep_time"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "diaries", "users"
  add_foreign_key "habit_comments", "habit_posts"
  add_foreign_key "habit_comments", "users"
  add_foreign_key "habit_likes", "habit_posts"
  add_foreign_key "habit_likes", "users"
  add_foreign_key "habit_posts", "users"
  add_foreign_key "item_comments", "item_posts"
  add_foreign_key "item_comments", "users"
  add_foreign_key "item_likes", "item_posts"
  add_foreign_key "item_likes", "users"
  add_foreign_key "item_posts", "users"
end
