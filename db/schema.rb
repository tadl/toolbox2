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

ActiveRecord::Schema.define(version: 2021_11_11_164217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "covers", force: :cascade do |t|
    t.integer "record_id"
    t.string "source"
    t.integer "staff_id"
    t.string "status"
    t.text "title"
    t.text "artist"
    t.string "publisher"
    t.string "release_date"
    t.string "item_type"
    t.text "track_list"
    t.text "abstract"
    t.string "coverart"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.boolean "active"
    t.string "short_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "infractions", force: :cascade do |t|
    t.string "description"
    t.string "first_offence"
    t.string "second_offence"
    t.string "subsiquent_offence"
    t.string "track"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "shortname"
    t.string "fullname"
    t.string "sunday"
    t.string "monday"
    t.string "tuesday"
    t.string "wednesday"
    t.string "thursday"
    t.string "friday"
    t.string "saturday"
    t.string "address"
    t.string "citystatezip"
    t.string "phone"
    t.string "email"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "fax"
    t.string "group"
  end

  create_table "patrons", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.boolean "no_name"
    t.string "card_number"
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.boolean "no_address"
    t.text "physical_description"
    t.string "alias"
    t.json "patronpic"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer "stat_id"
    t.integer "value"
    t.string "last_edit_by"
    t.integer "department_id"
    t.date "report_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "staffs", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.string "avatar"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stats", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "group_name"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trailers", force: :cascade do |t|
    t.integer "record_id"
    t.string "added_by"
    t.string "youtube_url"
    t.string "release_date"
    t.string "tile"
    t.string "artist"
    t.string "publisher"
    t.text "abstract"
    t.string "title"
    t.integer "user_id"
    t.boolean "cant_find", default: false
    t.string "item_type"
    t.text "track_list"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.string "avatar"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end


  create_view "soft_locations", sql_definition: <<-SQL
      SELECT departments.short_code AS shortname,
      departments.name
     FROM departments;
  SQL
  create_view "soft_statnames", sql_definition: <<-SQL
      SELECT stats.code,
      stats.name,
      stats.group_name AS groupname
     FROM stats;
  SQL
  create_view "soft_reporting_views", sql_definition: <<-SQL
      SELECT reports.report_date AS daterecorded,
      reports.created_at AS dateentered,
      reports.updated_at AS datelastmod,
      departments.short_code AS location,
      reports.last_edit_by AS usercreated,
      reports.last_edit_by AS userlastmod,
      stats.code AS stat,
      reports.value
     FROM ((reports
       JOIN departments ON ((reports.department_id = departments.id)))
       JOIN stats ON ((reports.stat_id = stats.id)));
  SQL
end
