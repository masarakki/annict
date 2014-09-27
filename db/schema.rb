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

ActiveRecord::Schema.define(version: 20140927222132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "user_id",                    null: false
    t.integer  "recipient_id",               null: false
    t.string   "recipient_type", limit: 510, null: false
    t.integer  "trackable_id",               null: false
    t.string   "trackable_type", limit: 510, null: false
    t.string   "action",         limit: 510, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["user_id"], name: "activities_user_id_idx", using: :btree

  create_table "channel_groups", force: true do |t|
    t.string   "sc_chgid",    limit: 510, null: false
    t.string   "name",        limit: 510, null: false
    t.integer  "sort_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "channel_groups", ["sc_chgid"], name: "channel_groups_sc_chgid_key", unique: true, using: :btree

  create_table "channel_works", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "work_id",    null: false
    t.integer  "channel_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "channel_works", ["channel_id"], name: "channel_works_channel_id_idx", using: :btree
  add_index "channel_works", ["user_id", "work_id", "channel_id"], name: "channel_works_user_id_work_id_channel_id_key", unique: true, using: :btree
  add_index "channel_works", ["user_id"], name: "channel_works_user_id_idx", using: :btree
  add_index "channel_works", ["work_id"], name: "channel_works_work_id_idx", using: :btree

  create_table "channels", force: true do |t|
    t.integer  "channel_group_id",                            null: false
    t.integer  "sc_chid",                                     null: false
    t.string   "name",             limit: 510,                null: false
    t.boolean  "published",                    default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "channels", ["channel_group_id"], name: "channels_channel_group_id_idx", using: :btree
  add_index "channels", ["sc_chid"], name: "channels_sc_chid_key", unique: true, using: :btree

  create_table "checkins", force: true do |t|
    t.integer  "user_id",                                          null: false
    t.integer  "episode_id",                                       null: false
    t.text     "comment"
    t.boolean  "spoil",                            default: false, null: false
    t.boolean  "modify_comment",                   default: false, null: false
    t.string   "twitter_url_hash",     limit: 510
    t.string   "facebook_url_hash",    limit: 510
    t.integer  "twitter_click_count",              default: 0,     null: false
    t.integer  "facebook_click_count",             default: 0,     null: false
    t.integer  "comments_count",                   default: 0,     null: false
    t.integer  "likes_count",                      default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkins", ["episode_id"], name: "checkins_episode_id_idx", using: :btree
  add_index "checkins", ["facebook_url_hash"], name: "checkins_facebook_url_hash_key", unique: true, using: :btree
  add_index "checkins", ["twitter_url_hash"], name: "checkins_twitter_url_hash_key", unique: true, using: :btree
  add_index "checkins", ["user_id"], name: "checkins_user_id_idx", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "user_id",                 null: false
    t.integer  "checkin_id",              null: false
    t.text     "body",                    null: false
    t.integer  "likes_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["checkin_id"], name: "comments_checkin_id_idx", using: :btree
  add_index "comments", ["user_id"], name: "comments_user_id_idx", using: :btree

  create_table "cover_images", force: true do |t|
    t.integer  "work_id",                null: false
    t.string   "file_name",  limit: 510, null: false
    t.string   "location",   limit: 510, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cover_images", ["work_id"], name: "cover_images_work_id_idx", using: :btree

  create_table "episodes", force: true do |t|
    t.integer  "work_id",                                null: false
    t.string   "number",         limit: 510
    t.integer  "sort_number",                default: 0, null: false
    t.integer  "sc_count"
    t.string   "title",          limit: 510
    t.boolean  "single"
    t.integer  "checkins_count",             default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "episodes", ["work_id", "sc_count"], name: "episodes_work_id_sc_count_key", unique: true, using: :btree
  add_index "episodes", ["work_id"], name: "episodes_work_id_idx", using: :btree

  create_table "follows", force: true do |t|
    t.integer  "user_id",      null: false
    t.integer  "following_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["following_id"], name: "follows_following_id_idx", using: :btree
  add_index "follows", ["user_id", "following_id"], name: "follows_user_id_following_id_key", unique: true, using: :btree
  add_index "follows", ["user_id"], name: "follows_user_id_idx", using: :btree

  create_table "items", force: true do |t|
    t.integer  "work_id"
    t.string   "name",       limit: 510, null: false
    t.string   "url",        limit: 510, null: false
    t.string   "image_uid",  limit: 510, null: false
    t.boolean  "main",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["work_id"], name: "items_work_id_idx", using: :btree

  create_table "likes", force: true do |t|
    t.integer  "user_id",                    null: false
    t.integer  "recipient_id",               null: false
    t.string   "recipient_type", limit: 510, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["user_id"], name: "likes_user_id_idx", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "user_id",                                    null: false
    t.integer  "action_user_id",                             null: false
    t.integer  "trackable_id",                               null: false
    t.string   "trackable_type", limit: 510,                 null: false
    t.string   "action",         limit: 510,                 null: false
    t.boolean  "read",                       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["action_user_id"], name: "notifications_action_user_id_idx", using: :btree
  add_index "notifications", ["user_id"], name: "notifications_user_id_idx", using: :btree

  create_table "profiles", force: true do |t|
    t.integer  "user_id",                                       null: false
    t.string   "name",                 limit: 510, default: "", null: false
    t.string   "description",          limit: 510, default: "", null: false
    t.string   "avatar_uid",           limit: 510
    t.string   "background_image_uid", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "profiles_user_id_idx", using: :btree
  add_index "profiles", ["user_id"], name: "profiles_user_id_key", unique: true, using: :btree

  create_table "programs", force: true do |t|
    t.integer  "channel_id",     null: false
    t.integer  "episode_id",     null: false
    t.integer  "work_id",        null: false
    t.datetime "started_at",     null: false
    t.datetime "sc_last_update"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "programs", ["channel_id", "episode_id"], name: "programs_channel_id_episode_id_key", unique: true, using: :btree
  add_index "programs", ["channel_id"], name: "programs_channel_id_idx", using: :btree
  add_index "programs", ["episode_id"], name: "programs_episode_id_idx", using: :btree
  add_index "programs", ["work_id"], name: "programs_work_id_idx", using: :btree

  create_table "providers", force: true do |t|
    t.integer  "user_id",                      null: false
    t.string   "name",             limit: 510, null: false
    t.string   "uid",              limit: 510, null: false
    t.string   "token",            limit: 510, null: false
    t.integer  "token_expires_at"
    t.string   "token_secret",     limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "providers", ["name", "uid"], name: "providers_name_uid_key", unique: true, using: :btree
  add_index "providers", ["user_id"], name: "providers_user_id_idx", using: :btree

  create_table "receptions", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "channel_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "receptions", ["channel_id"], name: "receptions_channel_id_idx", using: :btree
  add_index "receptions", ["user_id", "channel_id"], name: "receptions_user_id_channel_id_key", unique: true, using: :btree
  add_index "receptions", ["user_id"], name: "receptions_user_id_idx", using: :btree

  create_table "seasons", force: true do |t|
    t.string   "name",       limit: 510, null: false
    t.string   "slug",       limit: 510, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seasons", ["slug"], name: "seasons_slug_key", unique: true, using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", limit: 510, null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "sessions_session_id_key", unique: true, using: :btree

  create_table "staffs", force: true do |t|
    t.string   "email",              limit: 510, default: "", null: false
    t.string   "encrypted_password", limit: 510, default: "", null: false
    t.integer  "sign_in_count",                  default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip", limit: 510
    t.string   "last_sign_in_ip",    limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "staffs", ["email"], name: "staffs_email_key", unique: true, using: :btree

  create_table "statuses", force: true do |t|
    t.integer  "user_id",                     null: false
    t.integer  "work_id",                     null: false
    t.integer  "kind",                        null: false
    t.boolean  "latest",      default: false, null: false
    t.integer  "likes_count", default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statuses", ["user_id"], name: "statuses_user_id_idx", using: :btree
  add_index "statuses", ["work_id"], name: "statuses_work_id_idx", using: :btree

  create_table "twitter_bots", force: true do |t|
    t.string   "name",       limit: 510, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "twitter_bots", ["name"], name: "twitter_bots_name_key", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "username",             limit: 510,                 null: false
    t.string   "email",                limit: 510,                 null: false
    t.integer  "role",                                             null: false
    t.string   "encrypted_password",   limit: 510, default: "",    null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",   limit: 510
    t.string   "last_sign_in_ip",      limit: 510
    t.string   "confirmation_token",   limit: 510
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",    limit: 510
    t.integer  "checkins_count",                   default: 0,     null: false
    t.integer  "notifications_count",              default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "share_checkin",                    default: false
  end

  add_index "users", ["confirmation_token"], name: "users_confirmation_token_key", unique: true, using: :btree
  add_index "users", ["email"], name: "users_email_key", unique: true, using: :btree
  add_index "users", ["username"], name: "users_username_key", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  limit: 510, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 510, null: false
    t.string   "whodunnit",  limit: 510
    t.text     "object"
    t.datetime "created_at"
  end

  create_table "works", force: true do |t|
    t.integer  "season_id"
    t.integer  "sc_tid"
    t.string   "title",             limit: 510,              null: false
    t.integer  "media",                                      null: false
    t.string   "official_site_url", limit: 510, default: "", null: false
    t.string   "wikipedia_url",     limit: 510, default: "", null: false
    t.integer  "episodes_count",                default: 0,  null: false
    t.integer  "watchers_count",                default: 0,  null: false
    t.date     "released_at"
    t.datetime "nicoch_started_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "on_air",                                     null: false
    t.boolean  "fetch_syobocal",                             null: false
    t.string   "twitter_username",  limit: 510
    t.string   "twitter_hashtag",   limit: 510
  end

  add_index "works", ["sc_tid"], name: "works_sc_tid_key", unique: true, using: :btree
  add_index "works", ["season_id"], name: "works_season_id_idx", using: :btree

  add_foreign_key "activities", "users", name: "activities_user_id_fk", dependent: :delete

  add_foreign_key "channel_works", "channels", name: "channel_works_channel_id_fk", dependent: :delete
  add_foreign_key "channel_works", "users", name: "channel_works_user_id_fk", dependent: :delete
  add_foreign_key "channel_works", "works", name: "channel_works_work_id_fk", dependent: :delete

  add_foreign_key "channels", "channel_groups", name: "channels_channel_group_id_fk", dependent: :delete

  add_foreign_key "checkins", "episodes", name: "checkins_episode_id_fk", dependent: :delete
  add_foreign_key "checkins", "users", name: "checkins_user_id_fk", dependent: :delete

  add_foreign_key "comments", "checkins", name: "comments_checkin_id_fk", dependent: :delete
  add_foreign_key "comments", "users", name: "comments_user_id_fk", dependent: :delete

  add_foreign_key "cover_images", "works", name: "cover_images_work_id_fk", dependent: :delete

  add_foreign_key "episodes", "works", name: "episodes_work_id_fk", dependent: :delete

  add_foreign_key "follows", "users", name: "follows_following_id_fk", column: "following_id", dependent: :delete
  add_foreign_key "follows", "users", name: "follows_user_id_fk", dependent: :delete

  add_foreign_key "items", "works", name: "items_work_id_fk", dependent: :delete

  add_foreign_key "likes", "users", name: "likes_user_id_fk", dependent: :delete

  add_foreign_key "notifications", "users", name: "notifications_action_user_id_fk", column: "action_user_id", dependent: :delete
  add_foreign_key "notifications", "users", name: "notifications_user_id_fk", dependent: :delete

  add_foreign_key "profiles", "users", name: "profiles_user_id_fk", dependent: :delete

  add_foreign_key "programs", "channels", name: "programs_channel_id_fk", dependent: :delete
  add_foreign_key "programs", "episodes", name: "programs_episode_id_fk", dependent: :delete
  add_foreign_key "programs", "works", name: "programs_work_id_fk", dependent: :delete

  add_foreign_key "providers", "users", name: "providers_user_id_fk", dependent: :delete

  add_foreign_key "receptions", "channels", name: "receptions_channel_id_fk", dependent: :delete
  add_foreign_key "receptions", "users", name: "receptions_user_id_fk", dependent: :delete

  add_foreign_key "statuses", "users", name: "statuses_user_id_fk", dependent: :delete
  add_foreign_key "statuses", "works", name: "statuses_work_id_fk", dependent: :delete

  add_foreign_key "works", "seasons", name: "works_season_id_fk", dependent: :delete

end
