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

ActiveRecord::Schema.define(version: 20140828095956) do

  create_table "accommodations", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "accommodation_type"
    t.integer  "dwelling_type"
    t.integer  "size_sqm"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.integer  "parking_type"
    t.float    "price"
    t.date     "available_from"
    t.boolean  "pets_allowed"
    t.boolean  "smoking_allowed"
    t.integer  "preferred_gender"
    t.integer  "advertiser_type"
    t.integer  "share_type"
    t.integer  "places_available"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "author"
    t.text     "description"
    t.string   "thumbnail_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "isbns", force: true do |t|
    t.string  "isbn",    limit: 13
    t.integer "book_id"
  end

  add_index "isbns", ["book_id"], name: "index_isbns_on_book_id"

  create_table "location_hierarchies", force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "location_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "location_anc_desc_udx", unique: true
  add_index "location_hierarchies", ["descendant_id"], name: "location_desc_idx"

  create_table "locations", force: true do |t|
    t.string   "name"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "textbooks", force: true do |t|
    t.integer  "book_id"
    t.integer  "edition",    limit: 1
    t.integer  "price",      limit: 2
    t.integer  "condition",  limit: 1
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "textbooks", ["book_id"], name: "index_textbooks_on_book_id"
  add_index "textbooks", ["edition"], name: "index_textbooks_on_edition"
  add_index "textbooks", ["price"], name: "index_textbooks_on_price"

  create_table "universities", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
