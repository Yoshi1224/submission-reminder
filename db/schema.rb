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

ActiveRecord::Schema.define(version: 2020_12_21_152539) do

  create_table "submissions", force: :cascade do |t|
    t.string "title"
    t.datetime "limit"
    t.string "img"
    t.time "notice"
    t.integer "user_id"
    t.boolean "completed"
    t.boolean "star"
    t.date "due_date"
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "line_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
