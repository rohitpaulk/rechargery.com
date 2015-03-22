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

ActiveRecord::Schema.define(version: 20150321164011) do

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

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "short_description"
    t.text     "long_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_stores", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "store_id"
  end

  create_table "orders", force: true do |t|
    t.string   "orderid"
    t.string   "productname"
    t.integer  "status"
    t.integer  "shopstatus"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount"
    t.string   "emailused"
    t.integer  "ordertotal"
    t.integer  "store_id"
    t.integer  "tracking_id"
  end

  create_table "recharges", force: true do |t|
    t.string   "phonenumber"
    t.integer  "circlecode"
    t.integer  "operatorcode"
    t.integer  "amount"
    t.string   "txnid"
    t.integer  "status"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shorteners", force: true do |t|
    t.string   "in_url"
    t.string   "out_url"
    t.integer  "http_status_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", force: true do |t|
    t.string   "name"
    t.string   "image_name"
    t.text     "short_desc"
    t.text     "long_desc"
    t.integer  "status"
    t.integer  "tracking_reliability"
    t.boolean  "adblock_compatibility"
    t.integer  "payment_method"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tracker_type"
    t.string   "tracker_urlidentifier"
    t.string   "tracker_storeurl"
    t.string   "tracker_baseurl"
    t.string   "tracker_deeplinker"
    t.string   "tracker_afftag"
  end

  create_table "trackings", force: true do |t|
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "finalurl"
    t.integer  "store_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "authmethod"
    t.text     "rawpass"
    t.integer  "phone_operator"
    t.datetime "last_login"
    t.integer  "affiliate_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "fbaccesstoken"
  end

end
