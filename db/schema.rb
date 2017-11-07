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

ActiveRecord::Schema.define(version: 20171012220955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.text     "identity"
    t.string   "name"
    t.text     "description"
    t.string   "image_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["identity"], name: "index_achievements_on_identity", using: :btree
  end

  create_table "answers", force: :cascade do |t|
    t.string   "name"
    t.string   "handle"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "picture_url"
  end

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "badges", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "achievement_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["achievement_id"], name: "index_badges_on_achievement_id", using: :btree
    t.index ["user_id"], name: "index_badges_on_user_id", using: :btree
  end

  create_table "followers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "follower_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_followers_on_user_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "answer_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_questions_on_answer_id", using: :btree
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "round_questions", force: :cascade do |t|
    t.integer  "round_id"
    t.integer  "question_id"
    t.boolean  "answered",    default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["question_id"], name: "index_round_questions_on_question_id", using: :btree
    t.index ["round_id"], name: "index_round_questions_on_round_id", using: :btree
  end

  create_table "rounds", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "score"
    t.integer  "correct_count"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id"], name: "index_rounds_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.string   "location"
    t.string   "provider"
    t.string   "uid"
    t.string   "picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.string   "nickname"
    t.text     "bio"
    t.string   "handle"
    t.string   "twitter"
    t.string   "photo"
    t.string   "country"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "badges", "achievements"
  add_foreign_key "badges", "users"
  add_foreign_key "followers", "users"
  add_foreign_key "questions", "answers"
  add_foreign_key "round_questions", "questions"
  add_foreign_key "round_questions", "rounds"
  add_foreign_key "rounds", "users"
end
