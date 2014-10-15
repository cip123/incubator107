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

ActiveRecord::Schema.define(version: 20140824143503) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "article_links", force: true do |t|
    t.integer  "alias"
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
    t.text     "content"
  end

  add_index "article_translations", ["article_id"], name: "index_article_translations_on_article_id"
  add_index "article_translations", ["locale"], name: "index_article_translations_on_locale"

  create_table "articles", force: true do |t|
    t.boolean  "published"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assets", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "domain"
    t.string   "country"
    t.string   "facebook_page_id"
    t.string   "email"
    t.integer  "default_event_location_id"
    t.string   "google_analytics_code"
    t.string   "mailchimp_key"
    t.string   "newsletter_list_id"
    t.string   "workshop_list_id"
    t.integer  "workshop_groups_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["domain"], name: "index_cities_on_domain", unique: true
  add_index "cities", ["email"], name: "index_cities_on_email", unique: true

  create_table "city_groups", force: true do |t|
    t.integer  "group_id"
    t.integer  "city_id"
    t.integer  "mailchimp_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "city_translations", force: true do |t|
    t.integer  "city_id",             null: false
    t.string   "locale",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "default_donation"
    t.text     "default_whereabouts"
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

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

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
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", force: true do |t|
    t.boolean  "published"
    t.integer  "city_id"
    t.datetime "release_date"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_translations", force: true do |t|
    t.integer  "news_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "content"
  end

  add_index "news_translations", ["locale"], name: "index_news_translations_on_locale"
  add_index "news_translations", ["news_id"], name: "index_news_translations_on_news_id"

  create_table "newsletter_subscribers", force: true do |t|
    t.string   "email"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "newsletter_subscribers", ["city_id", "email"], name: "index_newsletter_subscribers_on_city_id_and_email", unique: true
  add_index "newsletter_subscribers", ["city_id"], name: "index_newsletter_subscribers_on_city_id"
  add_index "newsletter_subscribers", ["email"], name: "index_subscribers_on_email"

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.integer  "city_id"
    t.boolean  "verified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true

  create_table "registrations", force: true do |t|
    t.integer  "event_id"
    t.integer  "person_id"
    t.boolean  "notification_sent"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workshop_requests", force: true do |t|
    t.integer  "workshop_id"
    t.integer  "person_id"
    t.text     "reason"
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
    t.string   "facebook_album_id"
    t.datetime "release_date"
    t.boolean  "published"
    t.boolean  "requires_donation"
    t.boolean  "should_send_notification"
    t.integer  "master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
