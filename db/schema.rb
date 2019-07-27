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

ActiveRecord::Schema.define(version: 2019_07_27_133534) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_articles", force: :cascade do |t|
    t.integer "external_id"
    t.string "author"
    t.text "summary"
    t.string "img"
    t.datetime "created_at", null: false
    t.string "title"
    t.string "url"
    t.string "news_source"
    t.datetime "updated_at", null: false
    t.integer "publish_at"
  end

  create_table "game_genres", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_genres_games", id: false, force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "game_genre_id", null: false
    t.index ["game_genre_id"], name: "index_game_genres_games_on_game_genre_id"
    t.index ["game_id"], name: "index_game_genres_games_on_game_id"
  end

  create_table "game_videos", force: :cascade do |t|
    t.integer "external_id"
    t.string "url"
    t.string "name"
    t.text "description"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_videos_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "external_id"
    t.string "name"
    t.text "summary"
    t.text "storyline"
    t.string "cover"
    t.text "platform", array: true
    t.string "genres"
    t.date "first_release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "popularity"
  end

  create_table "games_platforms", id: false, force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "platform_id", null: false
    t.index ["game_id"], name: "index_games_platforms_on_game_id"
    t.index ["platform_id"], name: "index_games_platforms_on_platform_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.integer "external_id"
    t.string "abbreviation"
    t.string "alt_name"
    t.integer "generation"
    t.string "name"
    t.string "platform_logo"
    t.text "summary"
    t.text "details"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "screenshots", force: :cascade do |t|
    t.integer "external_id"
    t.string "url"
    t.integer "width"
    t.integer "height"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_screenshots_on_game_id"
  end

  add_foreign_key "game_videos", "games"
  add_foreign_key "screenshots", "games"
end
