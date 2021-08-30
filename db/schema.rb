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

ActiveRecord::Schema.define(version: 2021_08_30_100501) do

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "body"
    t.string "commentable_id"
    t.string "commentable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "followed_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "followed_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_user_id"], name: "index_followed_users_on_followed_user_id"
    t.index ["user_id", "followed_user_id"], name: "index_followed_users_on_user_id_and_followed_user_id", unique: true
    t.index ["user_id"], name: "index_followed_users_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "reacts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "reaction"
    t.string "reactable_type", null: false
    t.integer "reactable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reactable_type", "reactable_id"], name: "index_reacts_on_reactable"
    t.index ["user_id", "reactable_id"], name: "index_reacts_on_user_id_and_reactable_id", unique: true
    t.index ["user_id"], name: "index_reacts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.date "birth_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "users"
  add_foreign_key "followed_users", "users"
  add_foreign_key "followed_users", "users", column: "followed_user_id"
  add_foreign_key "posts", "users"
  add_foreign_key "reacts", "users"
end
