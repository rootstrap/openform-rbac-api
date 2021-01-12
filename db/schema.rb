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

ActiveRecord::Schema.define(version: 2021_01_07_202457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "api_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["api_key"], name: "index_accounts_on_api_key", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_key"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "form_question_id"
    t.bigint "form_submission_id"
    t.integer "version", null: false
    t.integer "row", null: false
    t.string "response", null: false
    t.string "metadata", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_question_id"], name: "index_answers_on_form_question_id"
    t.index ["form_submission_id"], name: "index_answers_on_form_submission_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_assignments_on_role_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "enablers", force: :cascade do |t|
    t.integer "version", null: false
    t.string "answer", null: false
    t.bigint "form_question_id"
    t.bigint "enable_form_question_id"
    t.bigint "form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enable_form_question_id"], name: "index_enablers_on_enable_form_question_id"
    t.index ["form_id"], name: "index_enablers_on_form_id"
    t.index ["form_question_id"], name: "index_enablers_on_form_question_id"
  end

  create_table "form_categories", force: :cascade do |t|
    t.string "name", null: false
    t.integer "version", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "forms_count", default: 0, null: false
    t.index ["name", "version"], name: "index_form_categories_on_name_and_version", unique: true
  end

  create_table "form_questions", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "section_id", null: false
    t.string "name", null: false
    t.integer "order", null: false
    t.integer "suborder", null: false
    t.boolean "enabled", default: true, null: false
    t.boolean "mandatory"
    t.string "description"
    t.string "long_description"
    t.string "default_text"
    t.boolean "enable_multiple"
    t.string "validations"
    t.string "formatter"
    t.string "form_question_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_form_questions_on_question_id"
    t.index ["section_id"], name: "index_form_questions_on_section_id"
  end

  create_table "form_submissions", force: :cascade do |t|
    t.boolean "complete"
    t.string "entity_type"
    t.integer "entity_id"
    t.bigint "form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_id", "entity_type"], name: "index_form_submissions_on_entity_id_and_entity_type"
    t.index ["form_id"], name: "index_form_submissions_on_form_id"
  end

  create_table "forms", force: :cascade do |t|
    t.string "name", null: false
    t.integer "version", null: false
    t.bigint "form_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_category_id"], name: "index_forms_on_form_category_id"
    t.index ["name", "version"], name: "index_forms_on_name_and_version", unique: true
    t.index ["name"], name: "index_forms_on_name"
  end

  create_table "permissions", force: :cascade do |t|
    t.integer "access_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "resource_id"
    t.index ["access_type", "resource_id"], name: "index_permissions_on_access_type_and_resource_id", unique: true
    t.index ["resource_id"], name: "index_permissions_on_resource_id"
  end

  create_table "question_options", force: :cascade do |t|
    t.string "option_parent_type"
    t.bigint "option_parent_id"
    t.string "name", null: false
    t.integer "version", null: false
    t.boolean "active", default: true, null: false
    t.string "metadata_type"
    t.string "metadata_label"
    t.string "metadata_validation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "value"
    t.boolean "enable_multiple", default: false, null: false
    t.index ["option_parent_type", "option_parent_id"], name: "index_question_option_on_type_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "default_text"
    t.string "code_name", null: false
    t.boolean "mandatory", null: false
    t.boolean "active", null: false
    t.boolean "enable_multiple", null: false
    t.integer "version", null: false
    t.string "validations"
    t.string "question_type", null: false
    t.string "formatter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resources", force: :cascade do |t|
    t.integer "resource_id"
    t.string "resource_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
    t.index ["account_id", "resource_id", "resource_type"], name: "index_resources_on_account_id_and_resource_id_and_resource_type", unique: true
    t.index ["account_id"], name: "index_resources_on_account_id"
  end

  create_table "role_permissions", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "permission_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id", "permission_id"], name: "index_role_permissions_on_role_id_and_permission_id", unique: true
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_roles_on_account_id"
    t.index ["name", "account_id"], name: "index_roles_on_name_and_account_id", unique: true
  end

  create_table "sections", force: :cascade do |t|
    t.string "parent_section_type"
    t.bigint "parent_section_id"
    t.string "name", null: false
    t.integer "order", null: false
    t.string "description"
    t.text "long_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "parent_section_type", "parent_section_id"], name: "unique same level sections name", unique: true
    t.index ["parent_section_type", "parent_section_id"], name: "index_sections_on_parent_section_type_and_parent_section_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "key", null: false
    t.string "value"
    t.index ["key"], name: "index_settings_on_key", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "external_id"
    t.bigint "account_id"
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["external_id", "account_id"], name: "index_users_on_external_id_and_account_id", unique: true
  end

  add_foreign_key "answers", "form_questions"
  add_foreign_key "answers", "form_submissions"
  add_foreign_key "assignments", "roles"
  add_foreign_key "assignments", "users"
  add_foreign_key "enablers", "form_questions"
  add_foreign_key "enablers", "form_questions", column: "enable_form_question_id"
  add_foreign_key "enablers", "forms"
  add_foreign_key "form_questions", "questions"
  add_foreign_key "form_questions", "sections"
  add_foreign_key "forms", "form_categories"
  add_foreign_key "permissions", "resources"
  add_foreign_key "resources", "accounts"
  add_foreign_key "roles", "accounts"
  add_foreign_key "users", "accounts"
end
