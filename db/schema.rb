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

ActiveRecord::Schema[7.0].define(version: 2022_07_01_062521) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "attempt_id", null: false
    t.bigint "question_id", null: false
    t.string "option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["attempt_id"], name: "index_answers_on_attempt_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "attempts", force: :cascade do |t|
    t.datetime "start_time", precision: nil
    t.datetime "end_time", precision: nil
    t.integer "score"
    t.boolean "pass"
    t.bigint "student_id"
    t.bigint "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_attempts_on_exercise_id"
    t.index ["student_id"], name: "index_attempts_on_student_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapter_contents", force: :cascade do |t|
    t.bigint "chapter_id", null: false
    t.bigint "content_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_chapter_contents_on_chapter_id"
    t.index ["content_id"], name: "index_chapter_contents_on_content_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.string "chapter_name"
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_chapters_on_subject_id"
  end

  create_table "contents", force: :cascade do |t|
    t.integer "sno"
    t.integer "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type_name", default: 0
  end

  create_table "exercises", force: :cascade do |t|
    t.string "title"
    t.integer "no_of_questions"
    t.integer "marks"
    t.time "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grades", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "content_id", null: false
    t.string "note_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_notes_on_content_id"
    t.index ["student_id"], name: "index_notes_on_student_id"
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "pdfs", force: :cascade do |t|
    t.string "title"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "text"
    t.string "option1"
    t.string "option2"
    t.string "option3"
    t.string "option4"
    t.integer "correct_answer"
    t.integer "mark"
    t.bigint "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_questions_on_exercise_id"
  end

  create_table "student_completes", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type_name", default: 0
    t.integer "type_id"
    t.index ["student_id"], name: "index_student_completes_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "full_name"
    t.string "mobile"
    t.string "email"
    t.date "dob"
    t.datetime "otp_timestamp", precision: nil
    t.string "profile_photo"
    t.bigint "board_id"
    t.bigint "grade_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["board_id"], name: "index_students_on_board_id"
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["grade_id"], name: "index_students_on_grade_id"
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  create_table "subjects", force: :cascade do |t|
    t.string "subject_name"
    t.bigint "board_id"
    t.bigint "grade_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_subjects_on_board_id"
    t.index ["grade_id"], name: "index_subjects_on_grade_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.string "thumbnail"
    t.time "duration"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "content_id", null: false
    t.boolean "upvote"
    t.boolean "downvote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_votes_on_content_id"
    t.index ["student_id"], name: "index_votes_on_student_id"
  end

  add_foreign_key "answers", "attempts"
  add_foreign_key "answers", "questions"
  add_foreign_key "attempts", "exercises"
  add_foreign_key "attempts", "students"
  add_foreign_key "chapter_contents", "chapters"
  add_foreign_key "chapter_contents", "contents"
  add_foreign_key "chapters", "subjects"
  add_foreign_key "notes", "contents"
  add_foreign_key "notes", "students"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "questions", "exercises"
  add_foreign_key "student_completes", "students"
  add_foreign_key "students", "boards"
  add_foreign_key "students", "grades"
  add_foreign_key "subjects", "boards"
  add_foreign_key "subjects", "grades"
  add_foreign_key "votes", "contents"
  add_foreign_key "votes", "students"
end
