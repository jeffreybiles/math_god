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

ActiveRecord::Schema.define(:version => 20120301054203) do

  create_table "images", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "picture"
    t.integer   "creator_id"
    t.string    "small_picture"
  end

  create_table "links", :force => true do |t|
    t.integer   "previous_id"
    t.integer   "next_id"
    t.boolean   "on_success"
    t.boolean   "on_failure"
    t.string    "extra_text"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "my_qualities", :force => true do |t|
    t.integer   "quality_id"
    t.integer   "user_id"
    t.integer   "level",               :default => 1
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.decimal   "exp_to_delevel",      :default => 0.0
    t.decimal   "exp_to_level",        :default => 40.0
    t.integer   "current_storylet_id"
    t.timestamp "expiration_time"
  end

  create_table "player_logs", :force => true do |t|
    t.integer   "user_id"
    t.integer   "storylet_id"
    t.boolean   "success"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "qualities", :force => true do |t|
    t.string    "name"
    t.integer   "storylet_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "quality_type"
    t.integer   "image_id"
    t.text      "description"
    t.integer   "time_limit"
  end

  create_table "requirements", :force => true do |t|
    t.integer   "storylet_id"
    t.integer   "quality_id"
    t.integer   "min_level"
    t.integer   "max_level"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "rewards", :force => true do |t|
    t.integer   "storylet_id"
    t.integer   "quality_id"
    t.boolean   "on_success"
    t.boolean   "on_fail"
    t.integer   "number_increased"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "storylets", :force => true do |t|
    t.string    "title"
    t.string    "subtitle"
    t.text      "main_text"
    t.text      "success_text"
    t.text      "failure_text"
    t.boolean   "has_challenge"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "preview_image_id"
    t.integer   "action_image_id"
    t.integer   "success_image_id"
    t.integer   "failure_image_id"
    t.integer   "god_id"
    t.integer   "challenge_level"
    t.integer   "cooloff_time"
    t.text      "notes"
    t.boolean   "special"
  end

  create_table "universes", :force => true do |t|
    t.string    "name"
    t.string    "focus"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.text      "description"
  end

  create_table "user_sessions", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "email",                              :null => false
    t.string    "persistence_token",                  :null => false
    t.string    "crypted_password"
    t.string    "password_salt"
    t.string    "single_access_token"
    t.string    "perishable_token"
    t.integer   "login_count",         :default => 0
    t.integer   "failed_login_count",  :default => 0
    t.timestamp "last_request_at"
    t.timestamp "current_login_at"
    t.timestamp "last_login_at"
    t.string    "current_login_ip"
    t.string    "last_login_ip"
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "admin"
    t.boolean   "contributor"
    t.boolean   "player"
    t.integer   "image_id"
    t.integer   "current_universe_id"
    t.string    "offer_code"
    t.integer   "current_storylet_id"
    t.integer   "energy"
    t.integer   "favor"
    t.timestamp "last_energy_tick"
  end

end
