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

ActiveRecord::Schema.define(version: 20140524142048) do

  create_table "article_translations", force: true do |t|
    t.integer  "article_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "text"
  end

  add_index "article_translations", ["article_id"], name: "index_article_translations_on_article_id"
  add_index "article_translations", ["locale"], name: "index_article_translations_on_locale"

  create_table "articles", force: true do |t|
    t.boolean  "display"
    t.datetime "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "domain"
    t.string   "country"
    t.decimal  "donation",   precision: 8, scale: 2
    t.string   "facebook"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "city_links", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "city_links", ["city_id", "name"], name: "index_city_links_on_city_id_and_name", unique: true
  add_index "city_links", ["city_id"], name: "index_city_links_on_city_id"
  add_index "city_links", ["name"], name: "index_city_links_on_name"

  create_table "city_translations", force: true do |t|
    t.integer  "city_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "city_translations", ["city_id"], name: "index_city_translations_on_city_id"
  add_index "city_translations", ["locale"], name: "index_city_translations_on_locale"

  create_table "event_participants", force: true do |t|
    t.integer  "event_id"
    t.integer  "participant_id"
    t.boolean  "notification_sent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.datetime "start_date"
    t.integer  "workshop_id"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_translations", force: true do |t|
    t.integer  "group_id",   null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "group_translations", ["group_id"], name: "index_group_translations_on_group_id"
  add_index "group_translations", ["locale"], name: "index_group_translations_on_locale"

  create_table "groups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location_translations", force: true do |t|
    t.integer  "location_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "address"
    t.text     "description"
  end

  add_index "location_translations", ["locale"], name: "index_location_translations_on_locale"
  add_index "location_translations", ["location_id"], name: "index_location_translations_on_location_id"

  create_table "locations", force: true do |t|
    t.integer  "city_id"
    t.string   "url"
    t.decimal  "lat",        precision: 15, scale: 10
    t.decimal  "lng",        precision: 15, scale: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["email"], name: "index_participants_on_email", unique: true

  create_table "workshop_donation_translations", force: true do |t|
    t.integer  "workshop_donation_id", null: false
    t.string   "locale",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
  end

  add_index "workshop_donation_translations", ["locale"], name: "index_workshop_donation_translations_on_locale"
  add_index "workshop_donation_translations", ["workshop_donation_id"], name: "index_workshop_donation_translations_on_workshop_donation_id"

  create_table "workshop_donations", force: true do |t|
    t.integer  "workshop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workshop_notification_translations", force: true do |t|
    t.integer  "workshop_notification_id", null: false
    t.string   "locale",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
  end

  add_index "workshop_notification_translations", ["locale"], name: "index_workshop_notification_translations_on_locale"
  add_index "workshop_notification_translations", ["workshop_notification_id"], name: "index_3cadcce01f7d046de35704f7bf7f2eba6c548ab3"

  create_table "workshop_notifications", force: true do |t|
    t.integer "workshop_id"
  end

  create_table "workshop_participants", force: true do |t|
    t.string   "workshop_id"
    t.string   "participant_id"
    t.string   "reason"
    t.boolean  "display"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workshop_translations", force: true do |t|
    t.integer  "workshop_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "what"
    t.text     "where"
    t.text     "who"
    t.text     "bring_along"
  end

  add_index "workshop_translations", ["locale"], name: "index_workshop_translations_on_locale"
  add_index "workshop_translations", ["workshop_id"], name: "index_workshop_translations_on_workshop_id"

  create_table "workshops", force: true do |t|
    t.integer  "city_id"
    t.integer  "group_id"
    t.string   "album"
    t.datetime "release_date"
    t.boolean  "enabled"
    t.boolean  "requires_notification"
    t.boolean  "should_send_notification"
    t.integer  "master_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
