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

ActiveRecord::Schema.define(version: 20150425123306) do

  create_table "ingredient_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "recipe_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "ingredient_groups", ["recipe_id"], name: "index_ingredient_groups_on_recipe_id", using: :btree

  create_table "ingredients", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "quantity",            limit: 255
    t.integer  "ingredient_group_id", limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "ingredients", ["ingredient_group_id"], name: "index_ingredients_on_ingredient_group_id", using: :btree

  create_table "links", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.integer  "recipe_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "links", ["recipe_id"], name: "index_links_on_recipe_id", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string   "name",         limit: 255,               null: false
    t.text     "instructions", limit: 65535,             null: false
    t.integer  "people",       limit: 4,     default: 1
    t.integer  "duration",     limit: 4,     default: 1
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                        limit: 255, null: false
    t.string   "crypted_password",             limit: 255
    t.string   "salt",                         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token",            limit: 255
    t.datetime "remember_me_token_expires_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree

  add_foreign_key "ingredient_groups", "recipes"
  add_foreign_key "ingredients", "ingredient_groups"
  add_foreign_key "links", "recipes"
end
