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

ActiveRecord::Schema[7.0].define(version: 16) do
  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.string "province_code", default: "QC"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "coordinate_id"
    t.string "phone_number", limit: 15
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coordinate_id"], name: "index_clients_on_coordinate_id"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "coordinates", force: :cascade do |t|
    t.string "civic_number", default: ""
    t.string "street_name", default: ""
    t.string "door_number"
    t.string "postal_code", limit: 7
    t.string "notes", default: ""
    t.integer "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_coordinates_on_city_id"
  end

  create_table "service_categories", force: :cascade do |t|
    t.string "label", null: false
    t.string "description"
    t.string "icon_path"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label"], name: "unique_service_category_labels", unique: true
    t.index ["parent_id"], name: "index_service_categories_on_parent_id"
  end

  create_table "service_offers", force: :cascade do |t|
    t.integer "service_id", null: false
    t.integer "service_provider_id", null: false
    t.string "description", default: ""
    t.decimal "min_price", precision: 7, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_service_offers_on_service_id"
    t.index ["service_provider_id"], name: "index_service_offers_on_service_provider_id"
    t.check_constraint "min_price >= 0", name: "min_price_cannot_be_negative"
  end

  create_table "service_providers", force: :cascade do |t|
    t.string "name", default: ""
    t.string "description", default: ""
    t.string "schedule", default: "MON to FRI, 9 to 5"
    t.string "phone_number", limit: 15
    t.string "email_address"
    t.integer "coordinate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coordinate_id"], name: "index_service_providers_on_coordinate_id"
  end

  create_table "service_quote_statuses", force: :cascade do |t|
    t.string "label", null: false
    t.string "description", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label"], name: "unique_service_quote_status_labels", unique: true
  end

  create_table "service_quotes", force: :cascade do |t|
    t.integer "service_request_id", null: false
    t.integer "service_provider_id", null: false
    t.integer "user_id", null: false
    t.integer "status_id", null: false
    t.decimal "price", precision: 7, scale: 2, default: "0.0"
    t.string "notes", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_provider_id"], name: "index_service_quotes_on_service_provider_id"
    t.index ["service_request_id"], name: "index_service_quotes_on_service_request_id"
    t.index ["status_id"], name: "index_service_quotes_on_status_id"
    t.index ["user_id"], name: "index_service_quotes_on_user_id"
    t.check_constraint "price >= 0", name: "price_cannot_be_negative"
  end

  create_table "service_request_statuses", force: :cascade do |t|
    t.string "label", null: false
    t.string "description", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label"], name: "unique_service_request_status_labels", unique: true
  end

  create_table "service_requests", force: :cascade do |t|
    t.integer "service_id", null: false
    t.integer "client_id"
    t.integer "coordinate_id"
    t.integer "service_request_status_id", null: false
    t.string "notes", default: ""
    t.decimal "min_price", precision: 7, scale: 2, default: "0.0"
    t.decimal "max_price", precision: 7, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_service_requests_on_client_id"
    t.index ["coordinate_id"], name: "index_service_requests_on_coordinate_id"
    t.index ["service_id"], name: "index_service_requests_on_service_id"
    t.index ["service_request_status_id"], name: "index_service_requests_on_service_request_status_id"
    t.check_constraint "max_price >= 0", name: "max_price_cannot_be_negative"
    t.check_constraint "max_price >= min_price", name: "max_price_cannot_be_less_than_min_price"
    t.check_constraint "min_price >= 0", name: "min_price_cannot_be_negative"
  end

  create_table "services", force: :cascade do |t|
    t.string "label", null: false
    t.string "description"
    t.integer "service_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label"], name: "unique_service_labels", unique: true
    t.index ["service_category_id"], name: "index_services_on_service_category_id"
  end

  create_table "transportation_services", force: :cascade do |t|
    t.integer "departure_city_id", null: false
    t.integer "arrival_city_id", null: false
    t.integer "service_id", null: false
    t.datetime "departure_time"
    t.datetime "arrival_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arrival_city_id"], name: "index_transportation_services_on_arrival_city_id"
    t.index ["departure_city_id"], name: "index_transportation_services_on_departure_city_id"
    t.index ["service_id"], name: "index_transportation_services_on_service_id"
    t.check_constraint "arrival_time > departure_time", name: "arrival_time_must_be_later_than_departure_time"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "unique_user_role_names", unique: true
  end

  create_table "user_service_provider_accesses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "service_provider_id", null: false
    t.integer "user_role_id", null: false
    t.integer "grantor_id"
    t.datetime "active_from", null: false
    t.datetime "inactive_from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grantor_id"], name: "index_user_service_provider_accesses_on_grantor_id"
    t.index ["service_provider_id"], name: "index_user_service_provider_accesses_on_service_provider_id"
    t.index ["user_id"], name: "index_user_service_provider_accesses_on_user_id"
    t.index ["user_role_id"], name: "index_user_service_provider_accesses_on_user_role_id"
    t.check_constraint "active_from < inactive_from", name: "inactive_from_must_be_later_than_active_from"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "unique_user_emails", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "unique_user_usernames", unique: true
  end

  add_foreign_key "clients", "coordinates"
  add_foreign_key "clients", "users"
  add_foreign_key "coordinates", "cities"
  add_foreign_key "service_offers", "service_providers"
  add_foreign_key "service_offers", "services"
  add_foreign_key "service_providers", "coordinates"
  add_foreign_key "service_quotes", "service_providers"
  add_foreign_key "service_quotes", "service_quote_statuses", column: "status_id"
  add_foreign_key "service_quotes", "service_requests"
  add_foreign_key "service_quotes", "users"
  add_foreign_key "service_requests", "clients"
  add_foreign_key "service_requests", "coordinates"
  add_foreign_key "service_requests", "service_request_statuses"
  add_foreign_key "service_requests", "services"
  add_foreign_key "services", "service_categories"
  add_foreign_key "transportation_services", "cities", column: "arrival_city_id"
  add_foreign_key "transportation_services", "cities", column: "departure_city_id"
  add_foreign_key "transportation_services", "services"
  add_foreign_key "user_service_provider_accesses", "service_providers"
  add_foreign_key "user_service_provider_accesses", "user_roles"
  add_foreign_key "user_service_provider_accesses", "users"
  add_foreign_key "user_service_provider_accesses", "users", column: "grantor_id"
end
