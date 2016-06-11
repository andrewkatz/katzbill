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

ActiveRecord::Schema.define(version: 20160315153527) do

  create_table "accounts", force: :cascade do |t|
    t.string "token", limit: 255
  end

  create_table "payments", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.datetime "last_paid_date"
    t.datetime "next_pay_date"
    t.string   "url",            limit: 255
    t.string   "type",           limit: 255
    t.integer  "account_id"
    t.integer  "due_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "allow_weekends",             default: false
    t.boolean  "autopay",                    default: false
  end

  add_index "payments", ["account_id"], name: "index_payments_on_account_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.integer  "account_id"
    t.string   "calendar_token",         limit: 255
    t.string   "authentication_token",   limit: 255
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id"
  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token"
  add_index "users", ["calendar_token"], name: "index_users_on_calendar_token"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
