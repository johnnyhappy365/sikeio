# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150726020959) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json     "info"
  end

  create_table "checkins", force: :cascade do |t|
    t.integer  "enrollment_id"
    t.text     "problem"
    t.string   "github_repository"
    t.integer  "time_cost"
    t.integer  "degree_of_difficulty"
    t.integer  "lesson_id"
    t.integer  "discourse_post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkins", ["enrollment_id"], name: "index_checkins_on_enrollment_id", using: :btree
  add_index "checkins", ["lesson_id"], name: "index_checkins_on_lesson_id", using: :btree

  create_table "course_invites", force: :cascade do |t|
    t.string   "token",            null: false
    t.integer  "course_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "start_time"
    t.string   "partnership_name"
  end

  add_index "course_invites", ["token"], name: "index_course_invites_on_token", unique: true, using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "current_version"
    t.string   "repo_url"
    t.string   "title"
    t.string   "permalink"
    t.string   "current_commit"
    t.boolean  "free",            default: false
    t.string   "color"
  end

  add_index "courses", ["name"], name: "index_courses_on_name", unique: true, using: :btree
  add_index "courses", ["permalink"], name: "index_courses_on_permalink", unique: true, using: :btree

  create_table "enrollments", force: :cascade do |t|
    t.integer  "user_id",                               null: false
    t.integer  "course_id",                             null: false
    t.string   "version"
    t.datetime "start_time"
    t.datetime "enroll_time"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "token",                                 null: false
    t.json     "personal_info"
    t.boolean  "activated",             default: false
    t.boolean  "paid",                  default: false
    t.string   "buddy_name"
    t.datetime "last_visit_time"
    t.datetime "invitation_sent_time"
    t.datetime "reminder_scheduled_at"
    t.string   "reminder_state"
    t.integer  "reminder_count",        default: 0
    t.boolean  "reminder_disabled",     default: false
    t.string   "partnership_name"
    t.string   "partnership_account"
  end

  add_index "enrollments", ["course_id"], name: "index_enrollments_on_course_id", using: :btree
  add_index "enrollments", ["user_id"], name: "index_enrollments_on_user_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.text     "overview"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "course_id"
    t.string   "permalink"
    t.integer  "discourse_topic_id"
    t.string   "project"
    t.integer  "discourse_qa_topic_id"
  end

  add_index "lessons", ["course_id", "name"], name: "index_lessons_on_course_id_and_name", unique: true, using: :btree
  add_index "lessons", ["course_id", "permalink"], name: "index_lessons_on_course_id_and_permalink", unique: true, using: :btree
  add_index "lessons", ["course_id"], name: "index_lessons_on_course_id", using: :btree

  create_table "subscribers", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.json     "personal_info"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "has_been_activated",          default: false
    t.integer  "discourse_user_id"
    t.string   "discourse_username"
    t.text     "introduce"
    t.boolean  "activated"
    t.datetime "sent_welcome_email"
    t.boolean  "introduce_submit"
    t.string   "introduce_submit_enrollment"
    t.string   "company"
    t.string   "resume_url"
  end

end
