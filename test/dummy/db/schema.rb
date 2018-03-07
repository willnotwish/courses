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

ActiveRecord::Schema.define(version: 20180212190136) do

  create_table "courses_course_memberships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "aasm_state"
    t.bigint "course_id"
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "payment_id"
    t.index ["course_id"], name: "index_courses_course_memberships_on_course_id"
    t.index ["member_id"], name: "index_courses_course_memberships_on_member_id"
    t.index ["payment_id"], name: "index_courses_course_memberships_on_payment_id"
  end

  create_table "courses_courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "starts_at"
    t.integer "duration"
    t.datetime "guest_period_expires_at"
    t.timestamp "enrolment_opens_at"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.text "description"
    t.timestamp "enrolment_closes_at"
    t.string "aasm_state"
    t.timestamp "published_at"
    t.bigint "owner_id"
    t.text "terms_and_conditions"
    t.boolean "include_provisional_in_capacity"
    t.index ["aasm_state"], name: "index_courses_courses_on_aasm_state"
    t.index ["owner_id"], name: "index_courses_courses_on_owner_id"
    t.index ["product_id"], name: "index_courses_courses_on_product_id"
    t.index ["published_at"], name: "index_courses_courses_on_published_at"
  end

  create_table "courses_user_roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_courses_user_roles_on_course_id"
    t.index ["role_id"], name: "index_courses_user_roles_on_role_id"
    t.index ["user_id"], name: "index_courses_user_roles_on_user_id"
  end

  create_table "payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paypal_payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "token"
    t.string "payer_id"
    t.integer "amount"
    t.string "currency"
    t.text "description"
    t.string "ip_address"
    t.string "transaction_id"
    t.boolean "success"
    t.boolean "test"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_permissions_on_name"
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "role_id"
    t.bigint "permission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "auth0_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "courses_course_memberships", "courses_courses", column: "course_id"
  add_foreign_key "courses_user_roles", "courses_courses", column: "course_id"
  add_foreign_key "courses_user_roles", "roles"
  add_foreign_key "courses_user_roles", "users"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
end
