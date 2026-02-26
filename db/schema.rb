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

ActiveRecord::Schema[8.1].define(version: 2026_02_26_144057) do
  create_table "documents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "image_url"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "document_id", null: false
    t.string "image_url"
    t.integer "position"
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_pages_on_document_id"
  end

  create_table "pins", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.integer "marker_number"
    t.integer "page_id"
    t.datetime "updated_at", null: false
    t.float "x_coordinate"
    t.float "y_coordinate"
    t.index ["page_id"], name: "index_pins_on_page_id"
  end

  add_foreign_key "pages", "documents"
  add_foreign_key "pins", "pages"
end
