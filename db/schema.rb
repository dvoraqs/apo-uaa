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

ActiveRecord::Schema.define(:version => 20130809093133) do

  create_table "events", :force => true do |t|
    t.string "google_id"
    t.string "facebook_id"
    t.string "google_link"
    t.string "facebook_link"
    t.string "updated_at"
    t.string "title"
    t.text   "description"
    t.string "location"
    t.string "start"
    t.string "end"
    t.string "service_area"
    t.string "status"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.string   "name"
    t.string   "status"
  end

end
