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

ActiveRecord::Schema[8.1].define(version: 2026_10_23_021357) do
  create_table "event_attendances", primary_key: ["event_id", "attendee_id"], force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "attendee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.date "date", null: false
    t.string "location", null: false
    t.integer "host_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_events_on_name", unique: true
  end

  create_table "user_profiles", force: :cascade do |t|
    t.string "city", null: false
    t.string "state", null: false
    t.string "country", null: false
    t.boolean "gender"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", null: false
    t.integer "remember"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember"], name: "index_users_on_remember", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "event_attendances", "events"
  add_foreign_key "event_attendances", "users", column: "attendee_id"
  add_foreign_key "events", "users", column: "host_id"
  add_foreign_key "user_profiles", "users"
end
