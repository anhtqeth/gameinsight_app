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

ActiveRecord::Schema.define(version: 2019_11_20_055306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.integer "external_id"
    t.string "name"
    t.string "description"
    t.string "logo"
    t.integer "start_date"
    t.integer "start_date_category"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "game_article_collections", force: :cascade do |t|
    t.integer "external_id"
    t.string "name"
    t.bigint "game_id"
    t.bigint "game_article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_article_id"], name: "index_game_article_collections_on_game_article_id"
    t.index ["game_id"], name: "index_game_article_collections_on_game_id"
  end

  create_table "game_article_translations", force: :cascade do |t|
    t.bigint "game_article_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.text "summary"
    t.index ["game_article_id"], name: "index_game_article_translations_on_game_article_id"
    t.index ["locale"], name: "index_game_article_translations_on_locale"
  end

  create_table "game_articles", force: :cascade do |t|
    t.integer "external_id"
    t.string "author"
    t.string "img"
    t.datetime "created_at", null: false
    t.string "url"
    t.string "news_source"
    t.datetime "updated_at", null: false
    t.integer "publish_at"
    t.bigint "game_article_collection_id"
    t.index ["game_article_collection_id"], name: "index_game_articles_on_game_article_collection_id"
  end

  create_table "game_collections", force: :cascade do |t|
    t.integer "external_id"
    t.string "name"
    t.string "url"
    t.text "description"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_collections_on_game_id"
  end

  create_table "game_genres", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "external_id"
    t.index ["slug"], name: "index_game_genres_on_slug", unique: true
  end

  create_table "game_genres_games", id: false, force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "game_genre_id", null: false
    t.index ["game_genre_id"], name: "index_game_genres_games_on_game_genre_id"
    t.index ["game_id"], name: "index_game_genres_games_on_game_id"
  end

  create_table "game_release_dates", force: :cascade do |t|
    t.date "date"
    t.bigint "game_id"
    t.bigint "platform_id"
    t.integer "region"
    t.integer "month"
    t.integer "year"
    t.integer "date_format_category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_release_dates_on_game_id"
    t.index ["platform_id"], name: "index_game_release_dates_on_platform_id"
  end

  create_table "game_translations", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "storyline"
    t.text "summary"
    t.index ["game_id"], name: "index_game_translations_on_game_id"
    t.index ["locale"], name: "index_game_translations_on_locale"
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
    t.string "cover"
    t.text "platform", array: true
    t.string "genres"
    t.date "first_release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "popularity"
    t.string "slug"
    t.bigint "game_collection_id"
    t.index ["game_collection_id"], name: "index_games_on_game_collection_id"
    t.index ["slug"], name: "index_games_on_slug", unique: true
  end

  create_table "games_platforms", id: false, force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "platform_id", null: false
    t.index ["game_id"], name: "index_games_platforms_on_game_id"
    t.index ["platform_id"], name: "index_games_platforms_on_platform_id"
  end

  create_table "involved_companies", force: :cascade do |t|
    t.boolean "developer"
    t.boolean "publisher"
    t.boolean "supporting"
    t.boolean "porting"
    t.bigint "game_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_involved_companies_on_company_id"
    t.index ["game_id"], name: "index_involved_companies_on_game_id"
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
    t.string "slug"
    t.index ["slug"], name: "index_platforms_on_slug", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.string "name"
    t.string "feature_img"
    t.integer "status"
    t.bigint "user_id"
    t.bigint "game_id"
    t.bigint "company_id"
    t.bigint "platform_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.string "slug"
    t.text "summary"
    t.string "author"
    t.index ["company_id"], name: "index_posts_on_company_id"
    t.index ["game_id"], name: "index_posts_on_game_id"
    t.index ["platform_id"], name: "index_posts_on_platform_id"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
    t.index ["user_id"], name: "index_posts_on_user_id"
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

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "game_article_collections", "game_articles"
  add_foreign_key "game_article_collections", "games"
  add_foreign_key "game_articles", "game_article_collections"
  add_foreign_key "game_collections", "games"
  add_foreign_key "game_release_dates", "games"
  add_foreign_key "game_release_dates", "platforms"
  add_foreign_key "game_videos", "games"
  add_foreign_key "games", "game_collections"
  add_foreign_key "involved_companies", "companies"
  add_foreign_key "involved_companies", "games"
  add_foreign_key "posts", "companies"
  add_foreign_key "posts", "games"
  add_foreign_key "posts", "platforms"
  add_foreign_key "posts", "users"
  add_foreign_key "screenshots", "games"
end
