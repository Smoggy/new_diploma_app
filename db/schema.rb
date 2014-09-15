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

ActiveRecord::Schema.define(version: 20140914144456) do

  create_table "semesters", force: true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "address"
    t.string   "school"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grade"
    t.string   "semester"
    t.string   "skype",      default: ""
  end

  create_table "students_subjects", id: false, force: true do |t|
    t.integer "student_id", null: false
    t.integer "subject_id", null: false
  end

  add_index "students_subjects", ["student_id", "subject_id"], name: "index_students_subjects_on_student_id_and_subject_id"

  create_table "subjects", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_reports", force: true do |t|
    t.integer  "student_id"
    t.integer  "task_id"
    t.integer  "status",                   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "report_file_file_name"
    t.string   "report_file_content_type"
    t.integer  "report_file_file_size"
    t.datetime "report_file_updated_at"
    t.string   "grade"
    t.string   "semester"
  end

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "task_file_file_name"
    t.string   "task_file_content_type"
    t.integer  "task_file_file_size"
    t.datetime "task_file_updated_at"
    t.string   "semester"
    t.string   "grade"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
