# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_20_213145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bonuses", force: :cascade do |t|
    t.bigint "frame_id", null: false
    t.integer "player_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "game_id", null: false
    t.integer "throws_to_sum"
    t.index ["frame_id"], name: "index_bonuses_on_frame_id"
    t.index ["game_id"], name: "index_bonuses_on_game_id"
  end

  create_table "frames", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "number"
    t.integer "ball_1"
    t.integer "ball_2"
    t.integer "ball_extra"
    t.integer "player_id"
    t.integer "bonus", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_frames_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "player_1"
    t.string "player_2"
    t.integer "current_player", default: 1
    t.integer "current_frame", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "bonuses", "frames"
  add_foreign_key "bonuses", "games"
  add_foreign_key "frames", "games"
end
