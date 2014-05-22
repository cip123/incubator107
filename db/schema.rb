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

ActiveRecord::Schema.define(version: 20140521162133) do

  create_table "articles", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "articles_cities", id: false, force: true do |t|
    t.integer "article_id"
    t.integer "city_id"
    t.string  "name"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "country"
    t.decimal  "donation",   precision: 8, scale: 2
    t.string   "facebook"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "city_article_aliases", force: true do |t|
    t.string   "name"
    t.string   "locale"
    t.integer  "article_id"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "city_article_aliases", ["city_id", "name", "locale"], name: "complex_index", unique: true
  add_index "city_article_aliases", ["city_id"], name: "index_city_article_aliases_on_city_id"
  add_index "city_article_aliases", ["locale"], name: "index_city_article_aliases_on_locale"
  add_index "city_article_aliases", ["name"], name: "index_city_article_aliases_on_name"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
