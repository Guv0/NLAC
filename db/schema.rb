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

ActiveRecord::Schema.define(version: 20170329150630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_cards", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "location"
    t.string   "phone"
    t.string   "industry"
    t.string   "linkedin_profile_url"
    t.string   "linkedin_picture_url"
    t.text     "description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "user_id"
    t.string   "company_name"
    t.index ["user_id"], name: "index_business_cards_on_user_id", using: :btree
  end

  create_table "connections", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_connections_on_contact_id", using: :btree
    t.index ["user_id"], name: "index_connections_on_user_id", using: :btree
  end

  create_table "tag_relations", force: :cascade do |t|
    t.integer  "business_card_id"
    t.integer  "tag_id"
    t.integer  "creator_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["business_card_id"], name: "index_tag_relations_on_business_card_id", using: :btree
    t.index ["tag_id"], name: "index_tag_relations_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "token_expiry"
    t.boolean  "company",                default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "business_cards", "users"
  add_foreign_key "connections", "users"
  add_foreign_key "connections", "users", column: "contact_id"
  add_foreign_key "tag_relations", "business_cards"
  add_foreign_key "tag_relations", "tags"
end
