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

ActiveRecord::Schema.define(version: 20171003110243) do

  create_table "authors", force: :cascade do |t|
    t.integer "content_id", null: false
    t.integer "mst_author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_authors_on_content_id"
    t.index ["mst_author_id"], name: "index_authors_on_mst_author_id"
  end

  create_table "contents", force: :cascade do |t|
    t.string "title", null: false
    t.string "url"
    t.string "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_contents_on_title"
    t.index ["url"], name: "index_contents_on_url", unique: true
  end

  create_table "mst_authors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_mst_authors_on_name", unique: true
  end

  create_table "mst_tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_mst_tags_on_name", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.integer "content_id", null: false
    t.integer "mst_tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_tags_on_content_id"
    t.index ["mst_tag_id"], name: "index_tags_on_mst_tag_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
