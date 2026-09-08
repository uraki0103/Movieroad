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

ActiveRecord::Schema[8.1].define(version: 2026_08_31_061350) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "companions", force: :cascade do |t|
    t.string "companion_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_companions_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "poster_url"
    t.integer "release_year"
    t.string "title", null: false
    t.integer "tmdb_id"
    t.datetime "updated_at", null: false
    t.index ["tmdb_id"], name: "index_movies_on_tmdb_id", unique: true
  end

  create_table "record_companions", force: :cascade do |t|
    t.bigint "companion_id", null: false
    t.datetime "created_at", null: false
    t.bigint "record_id", null: false
    t.datetime "updated_at", null: false
    t.index ["companion_id"], name: "index_record_companions_on_companion_id"
    t.index ["record_id", "companion_id"], name: "index_record_companions_on_record_id_and_companion_id", unique: true
    t.index ["record_id"], name: "index_record_companions_on_record_id"
  end

  create_table "records", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "impression"
    t.text "memory_note"
    t.bigint "movie_id"
    t.decimal "rating", precision: 3, scale: 1, null: false
    t.bigint "theater_id"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.datetime "watched_day", null: false
    t.index ["movie_id"], name: "index_records_on_movie_id"
    t.index ["theater_id"], name: "index_records_on_theater_id"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "theaters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "theater_name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_theaters_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "companions", "users"
  add_foreign_key "record_companions", "companions"
  add_foreign_key "record_companions", "records"
  add_foreign_key "records", "movies"
  add_foreign_key "records", "theaters"
  add_foreign_key "records", "users"
  add_foreign_key "theaters", "users"
end
