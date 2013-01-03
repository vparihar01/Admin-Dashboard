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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130103082748) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "casserver_lt", :force => true do |t|
    t.string   "ticket",          :null => false
    t.datetime "created_on",      :null => false
    t.datetime "consumed"
    t.string   "client_hostname", :null => false
  end

  add_index "casserver_lt", ["ticket"], :name => "index_casserver_lt_on_ticket"

  create_table "casserver_pgt", :force => true do |t|
    t.string   "ticket",            :null => false
    t.datetime "created_on",        :null => false
    t.string   "client_hostname",   :null => false
    t.string   "iou",               :null => false
    t.integer  "service_ticket_id", :null => false
  end

  add_index "casserver_pgt", ["ticket"], :name => "index_casserver_pgt_on_ticket"

  create_table "casserver_st", :force => true do |t|
    t.string   "ticket",            :null => false
    t.text     "service",           :null => false
    t.datetime "created_on",        :null => false
    t.datetime "consumed"
    t.string   "client_hostname",   :null => false
    t.string   "username",          :null => false
    t.string   "type",              :null => false
    t.integer  "granted_by_pgt_id"
    t.integer  "granted_by_tgt_id"
  end

  add_index "casserver_st", ["ticket"], :name => "index_casserver_st_on_ticket"

  create_table "casserver_tgt", :force => true do |t|
    t.string   "ticket",           :null => false
    t.datetime "created_on",       :null => false
    t.string   "client_hostname",  :null => false
    t.string   "username",         :null => false
    t.text     "extra_attributes"
  end

  add_index "casserver_tgt", ["ticket"], :name => "index_casserver_tgt_on_ticket"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "user_id"
    t.string   "integer"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "cas_authenticatable"
  end

end
