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

ActiveRecord::Schema.define(version: 20180310220702) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_items", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "item_id"
    t.index ["category_id"], name: "index_categories_items_on_category_id"
    t.index ["item_id"], name: "index_categories_items_on_item_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_members", id: false, force: :cascade do |t|
    t.integer "groups_id"
    t.integer "members_id"
    t.index ["groups_id"], name: "index_groups_members_on_groups_id"
    t.index ["members_id"], name: "index_groups_members_on_members_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "brand"
    t.string "name"
    t.string "description"
    t.string "serial_number"
    t.string "inventory_tag"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "loans", force: :cascade do |t|
    t.integer "member_id"
    t.integer "item_id"
    t.datetime "returned_at"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_loans_on_item_id"
    t.index ["member_id"], name: "index_loans_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "id_number"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "loans_count", default: 0, null: false
    t.integer "active_loans_count", default: 0, null: false
    t.index ["group_id"], name: "index_members_on_group_id"
  end

end
