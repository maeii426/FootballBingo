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

ActiveRecord::Schema.define(version: 2019_04_16_204452) do

  create_table "cards", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "cards_chips", id: false, force: :cascade do |t|
    t.integer "card_id"
    t.integer "chip_id"
    t.index ["card_id"], name: "index_cards_chips_on_card_id"
    t.index ["chip_id"], name: "index_cards_chips_on_chip_id"
  end

  create_table "chips", force: :cascade do |t|
    t.integer "translation_id"
    t.string "argument"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_id"], name: "index_chips_on_translation_id"
  end

  create_table "drives", force: :cascade do |t|
    t.integer "game_id"
    t.integer "team_id"
    t.string "start"
    t.string "end"
    t.integer "plays"
    t.integer "yards"
    t.string "top"
    t.string "start_how"
    t.string "start_qtr"
    t.string "start_time"
    t.string "start_spot"
    t.string "end_how"
    t.string "end_qtr"
    t.string "end_time"
    t.string "end_spot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_drives_on_game_id"
    t.index ["team_id"], name: "index_drives_on_team_id"
  end

  create_table "fgas", force: :cascade do |t|
    t.integer "game_id"
    t.integer "team_id"
    t.string "kicker"
    t.string "qtr"
    t.string "clock"
    t.integer "distance"
    t.boolean "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_fgas_on_game_id"
    t.index ["team_id"], name: "index_fgas_on_team_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "game_name"
    t.datetime "date"
    t.string "instant_winner"
    t.string "whoop_winner"
    t.integer "notify_by_email"
    t.string "source"
    t.string "version"
    t.string "generated"
    t.string "hometeam"
    t.string "visteam"
    t.integer "state"
  end

  create_table "linescoreconditions", force: :cascade do |t|
    t.integer "linescore_id"
    t.integer "translation_id"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["linescore_id"], name: "index_linescoreconditions_on_linescore_id"
    t.index ["translation_id"], name: "index_linescoreconditions_on_translation_id"
  end

  create_table "linescores", force: :cascade do |t|
    t.integer "game_id"
    t.integer "team_id"
    t.integer "prds"
    t.integer "score"
    t.string "line"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_linescores_on_game_id"
    t.index ["team_id"], name: "index_linescores_on_team_id"
  end

  create_table "playerconditions", force: :cascade do |t|
    t.integer "player_id"
    t.integer "translation_id"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_playerconditions_on_player_id"
    t.index ["translation_id"], name: "index_playerconditions_on_translation_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "game_id"
    t.integer "team_id"
    t.string "name"
    t.string "shortname"
    t.string "class_attr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "game_id"
    t.integer "team_id"
    t.string "qtr"
    t.string "clock"
    t.string "type"
    t.string "how"
    t.string "yds"
    t.string "scorer"
    t.string "passer"
    t.string "patby"
    t.string "pattype"
    t.string "patres"
    t.integer "plays"
    t.integer "drive"
    t.string "top"
    t.integer "vscore"
    t.integer "hscore"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_scores_on_game_id"
    t.index ["team_id"], name: "index_scores_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "nameid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "totalconditions", force: :cascade do |t|
    t.integer "total_id"
    t.integer "translation_id"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["total_id"], name: "index_totalconditions_on_total_id"
    t.index ["translation_id"], name: "index_totalconditions_on_translation_id"
  end

  create_table "totals", force: :cascade do |t|
    t.integer "game_id"
    t.integer "team_id"
    t.string "qtr"
    t.integer "totoff_plays"
    t.integer "totoff_yards"
    t.float "totoff_avg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_totals_on_game_id"
    t.index ["team_id"], name: "index_totals_on_team_id"
  end

  create_table "translations", force: :cascade do |t|
    t.string "tag"
    t.string "words"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.integer "game_id"
    t.string "gameid"
    t.date "date"
    t.integer "attend"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_venues_on_game_id"
  end

end
