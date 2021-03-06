# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101205122557) do

  create_table "incomeclassifications", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occupationclassifications", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parties", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partyroles", :force => true do |t|
    t.integer  "party_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.integer  "party_id"
    t.integer  "incomeclassification_id"
    t.integer  "occupationclassification_id"
    t.string   "current_last_name"
    t.string   "current_first_name"
    t.date     "birth_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rights", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "userrights", :force => true do |t|
    t.integer  "user_id"
    t.integer  "right_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "party_id"
    t.string   "username"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
