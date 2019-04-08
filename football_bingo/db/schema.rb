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

ActiveRecord::Schema.define(version: 2019_03_29_093618) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "cards_chips", id: false, force: :cascade do |t|
    t.bigint "card_id"
    t.bigint "chip_id"
    t.index ["card_id"], name: "index_cards_chips_on_card_id"
    t.index ["chip_id"], name: "index_cards_chips_on_chip_id"
  end

  create_table "chips", force: :cascade do |t|
    t.bigint "translation_id"
    t.string "argument"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_id"], name: "index_chips_on_translation_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.bigint "translation_id"
    t.bigint "game_id"
    t.float "value"
    t.index ["game_id"], name: "index_conditions_on_game_id"
    t.index ["translation_id"], name: "index_conditions_on_translation_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "game_name"
    t.datetime "date"
    t.boolean "instant_winner"
    t.boolean "whoop_winner"
  end

  create_table "translations", force: :cascade do |t|
    t.string "tag"
    t.string "words"
    t.bigint "condition_id"
    t.bigint "chip_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
