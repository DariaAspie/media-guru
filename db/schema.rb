# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_03_18_220443) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "category_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_favorites_on_user_id"
    t.index ["video_id"], name: "index_favorites_on_video_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "language_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "marks", force: :cascade do |t|
    t.bigint "video_id", null: false
    t.bigint "user_id", null: false
    t.integer "digit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "video_id"], name: "index_marks_on_user_id_and_video_id", unique: true
    t.index ["user_id"], name: "index_marks_on_user_id"
    t.index ["video_id"], name: "index_marks_on_video_id"
    t.check_constraint "digit >= 1 AND digit <= 5", name: "digit_check"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "text"
    t.bigint "user_id", null: false
    t.bigint "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
    t.index ["video_id"], name: "index_reviews_on_video_id"
  end

  create_table "speakers", force: :cascade do |t|
    t.string "speaker_fio", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_activities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "action", null: false
    t.datetime "login_time"
    t.datetime "logout_time"
    t.string "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_activities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "video_categories", force: :cascade do |t|
    t.bigint "video_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_video_categories_on_category_id"
    t.index ["video_id"], name: "index_video_categories_on_video_id"
  end

  create_table "video_languages", force: :cascade do |t|
    t.bigint "video_id", null: false
    t.bigint "language_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_video_languages_on_language_id"
    t.index ["video_id"], name: "index_video_languages_on_video_id"
  end

  create_table "video_speakers", force: :cascade do |t|
    t.bigint "video_id", null: false
    t.bigint "speaker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["speaker_id"], name: "index_video_speakers_on_speaker_id"
    t.index ["video_id"], name: "index_video_speakers_on_video_id"
  end

  create_table "video_tags", force: :cascade do |t|
    t.bigint "video_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_video_tags_on_tag_id"
    t.index ["video_id"], name: "index_video_tags_on_video_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "video_name", null: false
    t.text "video_description", null: false
    t.string "video_url", null: false
    t.string "picture_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key"
    t.string "low_res_key"
    t.integer "rating"
  end

  create_table "watched_videos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_watched_videos_on_user_id"
    t.index ["video_id"], name: "index_watched_videos_on_video_id"
  end

  add_foreign_key "favorites", "users"
  add_foreign_key "favorites", "videos"
  add_foreign_key "marks", "users"
  add_foreign_key "marks", "videos"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "videos"
  add_foreign_key "user_activities", "users"
  add_foreign_key "video_categories", "categories"
  add_foreign_key "video_categories", "videos"
  add_foreign_key "video_languages", "languages"
  add_foreign_key "video_languages", "videos"
  add_foreign_key "video_speakers", "speakers"
  add_foreign_key "video_speakers", "videos"
  add_foreign_key "video_tags", "tags"
  add_foreign_key "video_tags", "videos"
  add_foreign_key "watched_videos", "users"
  add_foreign_key "watched_videos", "videos"
  create_trigger("marks_after_insert_row_tr", :generated => true, :compatibility => 1).
      on("marks").
      after(:insert) do
    <<-SQL_ACTIONS
        UPDATE videos SET rating = (
          select avg(marks.digit)
          from marks
              where marks.video_id = NEW.video_id)
          WHERE videos.id = NEW.video_id;
    SQL_ACTIONS
  end

  create_trigger("marks_after_delete_row_tr", :generated => true, :compatibility => 1).
      on("marks").
      after(:delete) do
    <<-SQL_ACTIONS
        UPDATE videos SET rating = (
          select avg(marks.digit)
          from marks
              where marks.video_id = OLD.video_id)
          WHERE videos.id = OLD.video_id;
    SQL_ACTIONS
  end

end
