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

ActiveRecord::Schema[7.0].define(version: 2023_12_11_052047) do
  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "province_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "coordinate_id"
    t.string "phone_number"
    t.string "email_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coordinate_id"], name: "index_clients_on_coordinate_id"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "coordinates", force: :cascade do |t|
    t.string "civic_number"
    t.string "street_name"
    t.string "door_number"
    t.string "postal_code"
    t.string "notes"
    t.integer "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_coordinates_on_city_id"
  end

  create_table "service_categories", force: :cascade do |t|
    t.string "label"
    t.string "description"
    t.string "icon_path"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_service_categories_on_parent_id"
  end

  create_table "service_offers", force: :cascade do |t|
    t.integer "service_id", null: false
    t.integer "service_provider_id", null: false
    t.string "description"
    t.decimal "min_price"
    t.decimal "max_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_service_offers_on_service_id"
    t.index ["service_provider_id"], name: "index_service_offers_on_service_provider_id"
  end

  create_table "service_providers", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "schedule"
    t.string "phone_number"
    t.string "email_address"
    t.integer "coordinate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coordinate_id"], name: "index_service_providers_on_coordinate_id"
  end

  create_table "service_quote_statuses", force: :cascade do |t|
    t.string "label"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_quotes", force: :cascade do |t|
    t.integer "service_request_id", null: false
    t.integer "user_id", null: false
    t.integer "status_id", null: false
    t.decimal "price"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_request_id"], name: "index_service_quotes_on_service_request_id"
    t.index ["status_id"], name: "index_service_quotes_on_status_id"
    t.index ["user_id"], name: "index_service_quotes_on_user_id"
  end

  create_table "service_requests", force: :cascade do |t|
    t.integer "service_id", null: false
    t.integer "client_id", null: false
    t.integer "coordinate_id"
    t.string "notes"
    t.decimal "min_price"
    t.decimal "max_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_service_requests_on_client_id"
    t.index ["coordinate_id"], name: "index_service_requests_on_coordinate_id"
    t.index ["service_id"], name: "index_service_requests_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "label"
    t.string "description"
    t.integer "service_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_service_provider_accesses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "service_provider_id", null: false
    t.integer "user_role_id", null: false
    t.integer "grantor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grantor_id"], name: "index_user_service_provider_accesses_on_grantor_id"
    t.index ["service_provider_id"], name: "index_user_service_provider_accesses_on_service_provider_id"
    t.index ["user_id"], name: "index_user_service_provider_accesses_on_user_id"
    t.index ["user_role_id"], name: "index_user_service_provider_accesses_on_user_role_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clients", "coordinates"
  add_foreign_key "clients", "users"
  add_foreign_key "coordinates", "cities"
  add_foreign_key "service_offers", "service_providers"
  add_foreign_key "service_offers", "services"
  add_foreign_key "service_providers", "coordinates"
  add_foreign_key "service_quotes", "service_requests"
  add_foreign_key "service_quotes", "statuses"
  add_foreign_key "service_quotes", "users"
  add_foreign_key "service_requests", "clients"
  add_foreign_key "service_requests", "coordinates"
  add_foreign_key "service_requests", "services"
  add_foreign_key "services", "service_categories"
  add_foreign_key "transportation_services", "arrival_cities"
  add_foreign_key "transportation_services", "departure_cities"
  add_foreign_key "transportation_services", "services"
  add_foreign_key "user_service_provider_accesses", "grantors"
  add_foreign_key "user_service_provider_accesses", "service_providers"
  add_foreign_key "user_service_provider_accesses", "user_roles"
  add_foreign_key "user_service_provider_accesses", "users"
end
