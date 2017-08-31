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

ActiveRecord::Schema.define(version: 20170831051813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "plperl"
  enable_extension "plperlu"

  create_table "accounts", force: :cascade do |t|
    t.string "token"
    t.string "stripe_customer_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string   "name"
    t.datetime "last_paid_date"
    t.datetime "next_pay_date"
    t.string   "url"
    t.string   "type"
    t.integer  "account_id"
    t.integer  "due_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "allow_weekends", default: false
    t.boolean  "autopay",        default: false
  end

  add_index "payments", ["account_id"], name: "index_payments_on_account_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "account_id"
    t.string   "calendar_token"
    t.string   "authentication_token"
    t.string   "pushover_user_key"
    t.boolean  "notify_email",           default: true
    t.boolean  "notify_push",            default: false
    t.boolean  "notify_sms",             default: false
    t.string   "phone"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree
  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["calendar_token"], name: "index_users_on_calendar_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
