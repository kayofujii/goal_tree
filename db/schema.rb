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

ActiveRecord::Schema.define(version: 2021_04_21_113337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_records", force: :cascade do |t|
    t.string "action_image"
    t.text "action_comment"
    t.bigint "goal_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "goal_action_id"
    t.text "action_url"
    t.index ["goal_action_id"], name: "index_action_records_on_goal_action_id"
    t.index ["goal_id"], name: "index_action_records_on_goal_id"
    t.index ["user_id"], name: "index_action_records_on_user_id"
  end

  create_table "goal_actions", force: :cascade do |t|
    t.string "action_name"
    t.bigint "goal_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["goal_id"], name: "index_goal_actions_on_goal_id"
    t.index ["user_id"], name: "index_goal_actions_on_user_id"
  end

  create_table "goal_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "goals", force: :cascade do |t|
    t.text "goal_content", null: false
    t.text "identity_content", null: false
    t.integer "rank", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "goal_category_id"
    t.index ["goal_category_id"], name: "index_goals_on_goal_category_id"
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "sns_credentials", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "nickname"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_sns_credentials_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.text "description"
    t.text "icon"
    t.bigint "goal_id"
    t.string "display_name"
    t.string "provider"
    t.string "uid"
    t.text "url"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["goal_id"], name: "index_users_on_goal_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "action_records", "goal_actions"
  add_foreign_key "action_records", "goals"
  add_foreign_key "action_records", "users"
  add_foreign_key "goal_actions", "goals"
  add_foreign_key "goal_actions", "users"
  add_foreign_key "sns_credentials", "users"
end
