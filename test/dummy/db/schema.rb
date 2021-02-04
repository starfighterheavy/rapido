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

ActiveRecord::Schema.define(version: 2018_02_13_213155) do

  create_table "accounts", force: :cascade do |t|
    t.string "api_key", null: false
  end

  create_table "comlinks", force: :cascade do |t|
    t.string "token"
  end

  create_table "hydrospanners", force: :cascade do |t|
    t.string "name"
    t.integer "toolbox_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "token"
    t.integer "comlink_id"
    t.string "content"
  end

  create_table "protocol_droids", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
  end

  create_table "toolboxes", force: :cascade do |t|
    t.integer "account_id"
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.integer "account_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
