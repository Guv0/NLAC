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

ActiveRecord::Schema.define(version: 20170731133623) do

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
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "user_id"
    t.string   "company_name"
    t.string   "email"
    t.string   "photo"
    t.jsonb    "updates",              default: [],              array: true
    t.string   "position"
    t.index ["first_name"], name: "index_business_cards_on_first_name", using: :btree
    t.index ["user_id"], name: "index_business_cards_on_user_id", using: :btree
  end

  create_table "communities", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "photo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "community_memberships", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "community_id"
    t.boolean  "manager",      default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["community_id"], name: "index_community_memberships_on_community_id", using: :btree
    t.index ["member_id"], name: "index_community_memberships_on_member_id", using: :btree
  end

  create_table "community_messages", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "author_id"
    t.integer  "community_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["author_id"], name: "index_community_messages_on_author_id", using: :btree
    t.index ["community_id"], name: "index_community_messages_on_community_id", using: :btree
  end

  create_table "community_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "community_id"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["community_id"], name: "index_community_requests_on_community_id", using: :btree
    t.index ["user_id"], name: "index_community_requests_on_user_id", using: :btree
  end

  create_table "connection_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_connection_requests_on_contact_id", using: :btree
    t.index ["user_id"], name: "index_connection_requests_on_user_id", using: :btree
  end

  create_table "connections", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_connections_on_contact_id", using: :btree
    t.index ["user_id"], name: "index_connections_on_user_id", using: :btree
  end

  create_table "conversations", force: :cascade do |t|
    t.string   "subject"
    t.datetime "last_message"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "trash",        default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "started_on"
    t.index ["recipient_id"], name: "index_conversations_on_recipient_id", using: :btree
    t.index ["sender_id"], name: "index_conversations_on_sender_id", using: :btree
  end

  create_table "event_attendees", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "attendee_id"
    t.boolean  "attending",   default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["attendee_id"], name: "index_event_attendees_on_attendee_id", using: :btree
    t.index ["event_id"], name: "index_event_attendees_on_event_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "community_id"
    t.integer  "organiser_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["community_id"], name: "index_events_on_community_id", using: :btree
    t.index ["organiser_id"], name: "index_events_on_organiser_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.string   "sent_at"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "sender"
    t.index ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
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
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "guest",                  default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "business_cards", "users"
  add_foreign_key "community_memberships", "communities"
  add_foreign_key "community_memberships", "users", column: "member_id"
  add_foreign_key "community_messages", "communities"
  add_foreign_key "community_messages", "users", column: "author_id"
  add_foreign_key "community_requests", "communities"
  add_foreign_key "community_requests", "users"
  add_foreign_key "connection_requests", "users"
  add_foreign_key "connection_requests", "users", column: "contact_id"
  add_foreign_key "connections", "users"
  add_foreign_key "connections", "users", column: "contact_id"
  add_foreign_key "conversations", "users", column: "recipient_id"
  add_foreign_key "conversations", "users", column: "sender_id"
  add_foreign_key "event_attendees", "events"
  add_foreign_key "event_attendees", "users", column: "attendee_id"
  add_foreign_key "events", "communities"
  add_foreign_key "events", "users", column: "organiser_id"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "tag_relations", "business_cards"
  add_foreign_key "tag_relations", "tags"
end
