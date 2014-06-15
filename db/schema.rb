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

ActiveRecord::Schema.define(version: 20140615085421) do

  create_table "article_links", force: true do |t|
    t.string   "alias"
    t.integer  "city_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "article_links", ["alias"], name: "index_article_links_on_alias"
  add_index "article_links", ["city_id", "alias"], name: "index_article_links_on_city_id_and_alias", unique: true
  add_index "article_links", ["city_id"], name: "index_article_links_on_city_id"

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
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "domain"
    t.string   "country"
    t.decimal  "donation",         precision: 8, scale: 2
    t.decimal  "donation_student", precision: 8, scale: 2
    t.string   "facebook"
    t.string   "email"
    t.integer  "location_id"
    t.integer  "mailing_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["domain"], name: "index_cities_on_domain", unique: true
  add_index "cities", ["email"], name: "index_cities_on_email", unique: true

  create_table "city_articles", force: true do |t|
    t.integer  "city_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "city_articles", ["article_id"], name: "index_city_articles_on_article_id"
  add_index "city_articles", ["city_id", "article_id"], name: "index_city_articles_on_city_id_and_article_id", unique: true
  add_index "city_articles", ["city_id"], name: "index_city_articles_on_city_id"

  create_table "city_news", force: true do |t|
    t.integer  "city_id"
    t.integer  "news_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "city_news", ["city_id", "news_id"], name: "index_city_news_on_city_id_and_news_id", unique: true
  add_index "city_news", ["city_id"], name: "index_city_news_on_city_id"
  add_index "city_news", ["news_id"], name: "index_city_news_on_news_id"

  create_table "city_translations", force: true do |t|
    t.integer  "city_id",              null: false
    t.string   "locale",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "donation_alternative"
  end

  add_index "city_translations", ["city_id"], name: "index_city_translations_on_city_id"
  add_index "city_translations", ["locale"], name: "index_city_translations_on_locale"

  create_table "contact_people", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.integer  "city_id"
    t.integer  "index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_person_translations", force: true do |t|
    t.integer  "contact_person_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "about"
    t.string   "team"
  end

  add_index "contact_person_translations", ["contact_person_id"], name: "index_contact_person_translations_on_contact_person_id"
  add_index "contact_person_translations", ["locale"], name: "index_contact_person_translations_on_locale"

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
    t.integer  "location_id"
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

  create_table "mailing_list_subscribers", force: true do |t|
    t.integer  "subscriber_id"
    t.integer  "mailing_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mailing_lists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", force: true do |t|
    t.boolean  "published"
    t.datetime "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_translations", force: true do |t|
    t.integer  "news_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "text"
  end

  add_index "news_translations", ["locale"], name: "index_news_translations_on_locale"
  add_index "news_translations", ["news_id"], name: "index_news_translations_on_news_id"

  create_table "participants", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.boolean  "verified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["email"], name: "index_participants_on_email", unique: true

  create_table "subscribers", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "workshop_id",  null: false
    t.string   "locale",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
    t.text     "with_whom"
    t.text     "bring_along"
    t.text     "whereabouts"
    t.text     "donation"
    t.text     "notification"
  end

  add_index "workshop_translations", ["locale"], name: "index_workshop_translations_on_locale"
  add_index "workshop_translations", ["workshop_id"], name: "index_workshop_translations_on_workshop_id"

  create_table "workshops", force: true do |t|
    t.integer  "city_id"
    t.integer  "group_id"
    t.string   "album"
    t.datetime "release_date"
    t.boolean  "published"
    t.boolean  "requires_donation"
    t.boolean  "should_send_notification"
    t.integer  "master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
