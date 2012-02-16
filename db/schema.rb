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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120215202212) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",                                :null => false
    t.string   "number",       :default => "",        :null => false
    t.boolean  "system",       :default => false,     :null => false
    t.boolean  "payee",        :default => false,     :null => false
    t.boolean  "favorite",     :default => false,     :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "account_type", :default => "Account", :null => false
    t.text     "settings"
    t.integer  "currency_id"
  end

  add_index "accounts", ["account_type"], :name => "index_accounts_on_account_type"
  add_index "accounts", ["currency_id"], :name => "index_accounts_on_currency_id"
  add_index "accounts", ["favorite"], :name => "index_accounts_on_favorite"
  add_index "accounts", ["payee"], :name => "index_accounts_on_payee"
  add_index "accounts", ["system"], :name => "index_accounts_on_system"
  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name",                           :null => false
    t.string   "description"
    t.integer  "parent_id"
    t.boolean  "expense",     :default => false, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "user_id"
    t.string   "locale",      :default => "en",  :null => false
  end

  add_index "categories", ["expense"], :name => "index_categories_on_expense"
  add_index "categories", ["name"], :name => "index_categories_on_name"
  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
  add_index "categories", ["user_id"], :name => "index_categories_on_user_id"

  create_table "currencies", :force => true do |t|
    t.string   "code",       :null => false
    t.string   "name",       :null => false
    t.string   "locale",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "currencies", ["code"], :name => "index_currencies_on_code"
  add_index "currencies", ["name"], :name => "index_currencies_on_name"

  create_table "transaction_items", :force => true do |t|
    t.integer  "account_id",                                   :null => false
    t.integer  "transaction_id",                               :null => false
    t.integer  "category_id"
    t.string   "memo"
    t.decimal  "amount",         :precision => 9, :scale => 2, :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "transaction_items", ["account_id"], :name => "index_transaction_items_on_account_id"
  add_index "transaction_items", ["category_id"], :name => "index_transaction_items_on_category_id"
  add_index "transaction_items", ["transaction_id"], :name => "index_transaction_items_on_transaction_id"

  create_table "transactions", :force => true do |t|
    t.string   "event",          :null => false
    t.date     "operation_date", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "transactions", ["operation_date"], :name => "index_transactions_on_operation_date"

  create_table "users", :force => true do |t|
    t.string   "username",        :null => false
    t.string   "email",           :null => false
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "settings"
    t.integer  "currency_id"
  end

  add_index "users", ["currency_id"], :name => "index_users_on_currency_id"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["password_digest"], :name => "index_users_on_password_digest"
  add_index "users", ["username"], :name => "index_users_on_username"

end
