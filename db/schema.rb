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

ActiveRecord::Schema[8.0].define(version: 2025_01_16_153326) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "analytics_reports", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.jsonb "metrics"
    t.text "insights"
    t.text "recommendations"
    t.date "date"
    t.string "report_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_analytics_reports_on_project_id"
  end

  create_table "dashboard_metrics", force: :cascade do |t|
    t.string "name"
    t.integer "value"
    t.string "category"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dashboard_metrics_on_user_id"
  end

  create_table "dashboard_widgets", force: :cascade do |t|
    t.string "name"
    t.string "widget_type"
    t.integer "position"
    t.bigint "user_id", null: false
    t.jsonb "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dashboard_widgets_on_user_id"
  end

  create_table "development_projects", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "phase"
    t.date "timeline"
    t.decimal "budget", precision: 10, scale: 2
    t.string "tech_stack"
    t.text "milestones"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_development_projects_on_project_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "date"
    t.string "location"
    t.integer "capacity"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forums", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "category"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investments", force: :cascade do |t|
    t.bigint "startup_id", null: false
    t.decimal "amount"
    t.date "investment_date"
    t.string "investment_type"
    t.string "investor_name"
    t.string "investment_round"
    t.decimal "equity_percentage", precision: 10, scale: 2
    t.decimal "valuation_at_investment", precision: 10, scale: 2
    t.text "investment_terms"
    t.integer "board_seats"
    t.string "due_diligence_status"
    t.string "documents_url"
    t.boolean "lead_investor"
    t.boolean "follow_on_investment"
    t.text "notes"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["startup_id"], name: "index_investments_on_startup_id"
  end

  create_table "login_histories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "market_researches", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.integer "market_size"
    t.text "competitors"
    t.text "target_audience"
    t.text "pain_points"
    t.text "opportunities"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_market_researches_on_project_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "mentor_id", null: false
    t.bigint "user_id", null: false
    t.datetime "date"
    t.string "status"
    t.text "notes"
    t.string "meeting_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentor_id"], name: "index_meetings_on_mentor_id"
    t.index ["user_id"], name: "index_meetings_on_user_id"
  end

  create_table "mentors", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "expertise"
    t.string "availability"
    t.decimal "rating"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["user_id"], name: "index_mentors_on_user_id"
  end

  create_table "metrics", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.date "date"
    t.decimal "revenue", precision: 10, scale: 2
    t.integer "total_users"
    t.integer "active_users"
    t.decimal "churn_rate", precision: 10, scale: 3
    t.decimal "customer_acquisition_cost", precision: 10, scale: 4
    t.decimal "lifetime_value", precision: 10, scale: 2
    t.decimal "burn_rate", precision: 10, scale: 3
    t.integer "runway_months"
    t.decimal "funding_raised", precision: 10, scale: 2
    t.integer "investor_meetings"
    t.integer "pilot_projects"
    t.integer "partnerships"
    t.integer "team_size"
    t.integer "website_visits"
    t.decimal "conversion_rate", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_metrics_on_project_id"
    t.index ["user_id"], name: "index_metrics_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "forum_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forum_id"], name: "index_posts_on_forum_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "status"
    t.bigint "user_id", null: false
    t.string "target_market"
    t.string "revenue_model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "featured", default: false
    t.boolean "success_story", default: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "category"
    t.string "file_url"
    t.string "access_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "startups", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "founded_date"
    t.string "website"
    t.string "industry"
    t.integer "company_size"
    t.string "stage"
    t.decimal "total_funding", precision: 10, scale: 2
    t.string "headquarters"
    t.string "founders"
    t.string "logo_url"
    t.string "status"
    t.string "pitch_deck_url"
    t.decimal "valuation", precision: 10, scale: 2
    t.decimal "revenue", precision: 10, scale: 2
    t.integer "employee_count"
    t.string "business_model"
    t.string "target_market"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.index ["slug"], name: "index_startups_on_slug", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "plan_type"
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "success_stories", force: :cascade do |t|
    t.string "title"
    t.string "founder_name"
    t.string "founder_avatar"
    t.string "company_name"
    t.string "industry"
    t.text "summary"
    t.string "funding_raised"
    t.integer "team_size"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.integer "status", default: 0, null: false
    t.string "role", default: "viewer"
    t.string "name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "analytics_reports", "projects"
  add_foreign_key "dashboard_metrics", "users"
  add_foreign_key "dashboard_widgets", "users"
  add_foreign_key "development_projects", "projects"
  add_foreign_key "investments", "startups"
  add_foreign_key "market_researches", "projects"
  add_foreign_key "meetings", "mentors"
  add_foreign_key "meetings", "users"
  add_foreign_key "mentors", "users"
  add_foreign_key "metrics", "projects"
  add_foreign_key "metrics", "users"
  add_foreign_key "posts", "forums"
  add_foreign_key "posts", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "subscriptions", "users"
end
