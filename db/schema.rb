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

ActiveRecord::Schema.define(version: 20150329172200) do

  create_table "comfy_blog_comments", force: true do |t|
    t.integer  "post_id",                      null: false
    t.integer  "author_id",                    null: false
    t.text     "content"
    t.boolean  "is_published", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_blog_comments", ["post_id", "created_at"], name: "index_comfy_blog_comments_on_post_id_and_created_at", using: :btree
  add_index "comfy_blog_comments", ["post_id", "is_published", "created_at"], name: "index_blog_comments_on_post_published_created", using: :btree

  create_table "comfy_blog_posts", force: true do |t|
    t.integer  "blog_id",                                  null: false
    t.string   "title",                                    null: false
    t.string   "slug",                                     null: false
    t.text     "content"
    t.string   "excerpt",      limit: 1024
    t.integer  "author_id"
    t.integer  "year",                                     null: false
    t.integer  "month",        limit: 2,                   null: false
    t.boolean  "is_published",              default: true, null: false
    t.datetime "published_at",                             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_blog_posts", ["created_at"], name: "index_comfy_blog_posts_on_created_at", using: :btree
  add_index "comfy_blog_posts", ["is_published", "created_at"], name: "index_comfy_blog_posts_on_is_published_and_created_at", using: :btree
  add_index "comfy_blog_posts", ["is_published", "year", "month", "slug"], name: "index_blog_posts_on_published_year_month_slug", using: :btree

  create_table "comfy_blogs", force: true do |t|
    t.integer "site_id",                             null: false
    t.string  "label",                               null: false
    t.string  "identifier",                          null: false
    t.string  "app_layout",  default: "application", null: false
    t.string  "path"
    t.text    "description"
  end

  add_index "comfy_blogs", ["identifier"], name: "index_comfy_blogs_on_identifier", using: :btree
  add_index "comfy_blogs", ["site_id", "path"], name: "index_comfy_blogs_on_site_id_and_path", using: :btree

  create_table "comfy_cms_blocks", force: true do |t|
    t.integer  "blockable_id",                    null: false
    t.string   "identifier",                      null: false
    t.text     "content",        limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "blockable_type"
  end

  add_index "comfy_cms_blocks", ["blockable_id", "identifier"], name: "index_comfy_cms_blocks_on_blockable_id_and_identifier", using: :btree
  add_index "comfy_cms_blocks", ["blockable_type"], name: "index_comfy_cms_blocks_on_blockable_type", using: :btree

  create_table "comfy_cms_categories", force: true do |t|
    t.integer "site_id",          null: false
    t.string  "label",            null: false
    t.string  "categorized_type", null: false
  end

  add_index "comfy_cms_categories", ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_cat_type_and_label", unique: true, using: :btree

  create_table "comfy_cms_categorizations", force: true do |t|
    t.integer "category_id",      null: false
    t.string  "categorized_type", null: false
    t.integer "categorized_id",   null: false
  end

  add_index "comfy_cms_categorizations", ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true, using: :btree

  create_table "comfy_cms_files", force: true do |t|
    t.integer  "site_id",                                    null: false
    t.integer  "block_id"
    t.string   "label",                                      null: false
    t.string   "file_file_name",                             null: false
    t.string   "file_content_type",                          null: false
    t.integer  "file_file_size",                             null: false
    t.string   "description",       limit: 2048
    t.integer  "position",                       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_files", ["site_id", "block_id"], name: "index_comfy_cms_files_on_site_id_and_block_id", using: :btree
  add_index "comfy_cms_files", ["site_id", "file_file_name"], name: "index_comfy_cms_files_on_site_id_and_file_file_name", using: :btree
  add_index "comfy_cms_files", ["site_id", "label"], name: "index_comfy_cms_files_on_site_id_and_label", using: :btree
  add_index "comfy_cms_files", ["site_id", "position"], name: "index_comfy_cms_files_on_site_id_and_position", using: :btree

  create_table "comfy_cms_layouts", force: true do |t|
    t.integer  "site_id",                                     null: false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                                       null: false
    t.string   "identifier",                                  null: false
    t.text     "content",    limit: 16777215
    t.text     "css",        limit: 16777215
    t.text     "js",         limit: 16777215
    t.integer  "position",                    default: 0,     null: false
    t.boolean  "is_shared",                   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_layouts", ["parent_id", "position"], name: "index_comfy_cms_layouts_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_layouts", ["site_id", "identifier"], name: "index_comfy_cms_layouts_on_site_id_and_identifier", unique: true, using: :btree

  create_table "comfy_cms_pages", force: true do |t|
    t.integer  "site_id",                                         null: false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                                           null: false
    t.string   "slug"
    t.string   "full_path",                                       null: false
    t.text     "content_cache",  limit: 16777215
    t.integer  "position",                        default: 0,     null: false
    t.integer  "children_count",                  default: 0,     null: false
    t.boolean  "is_published",                    default: true,  null: false
    t.boolean  "is_shared",                       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_pages", ["parent_id", "position"], name: "index_comfy_cms_pages_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_pages", ["site_id", "full_path"], name: "index_comfy_cms_pages_on_site_id_and_full_path", using: :btree

  create_table "comfy_cms_revisions", force: true do |t|
    t.string   "record_type",                  null: false
    t.integer  "record_id",                    null: false
    t.text     "data",        limit: 16777215
    t.datetime "created_at"
  end

  add_index "comfy_cms_revisions", ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_rtype_and_rid_and_created_at", using: :btree

  create_table "comfy_cms_sites", force: true do |t|
    t.string  "label",                       null: false
    t.string  "identifier",                  null: false
    t.string  "hostname",                    null: false
    t.string  "path"
    t.string  "locale",      default: "en",  null: false
    t.boolean "is_mirrored", default: false, null: false
  end

  add_index "comfy_cms_sites", ["hostname"], name: "index_comfy_cms_sites_on_hostname", using: :btree
  add_index "comfy_cms_sites", ["is_mirrored"], name: "index_comfy_cms_sites_on_is_mirrored", using: :btree

  create_table "comfy_cms_snippets", force: true do |t|
    t.integer  "site_id",                                     null: false
    t.string   "label",                                       null: false
    t.string   "identifier",                                  null: false
    t.text     "content",    limit: 16777215
    t.integer  "position",                    default: 0,     null: false
    t.boolean  "is_shared",                   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_snippets", ["site_id", "identifier"], name: "index_comfy_cms_snippets_on_site_id_and_identifier", unique: true, using: :btree
  add_index "comfy_cms_snippets", ["site_id", "position"], name: "index_comfy_cms_snippets_on_site_id_and_position", using: :btree

  create_table "events", force: true do |t|
    t.string   "title"
    t.date     "event_date"
    t.text     "description"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["description"], name: "fulltext_index_events_description", type: :fulltext
  add_index "events", ["event_date"], name: "index_events_on_event_date", using: :btree

  create_table "exercises", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gallery_galleries", force: true do |t|
    t.string   "title",                             null: false
    t.string   "identifier",                        null: false
    t.text     "description"
    t.integer  "full_width",        default: 640,   null: false
    t.integer  "full_height",       default: 480,   null: false
    t.boolean  "force_ratio_full",  default: false, null: false
    t.integer  "thumb_width",       default: 150,   null: false
    t.integer  "thumb_height",      default: 150,   null: false
    t.boolean  "force_ratio_thumb", default: true,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gallery_galleries", ["identifier"], name: "index_gallery_galleries_on_identifier", unique: true, using: :btree

  create_table "gallery_photos", force: true do |t|
    t.integer  "gallery_id",                     null: false
    t.string   "title"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.integer  "position",           default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gallery_photos", ["gallery_id", "position"], name: "index_gallery_photos_on_gallery_id_and_position", using: :btree

  create_table "journals", force: true do |t|
    t.integer  "users_exercises_id"
    t.integer  "repetition_id"
    t.string   "weight_time"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "login_tokens", force: true do |t|
    t.integer  "user_id",       null: false
    t.string   "token"
    t.boolean  "permanent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_accessed"
  end

  add_index "login_tokens", ["last_accessed"], name: "index_login_tokens_on_last_accessed", using: :btree
  add_index "login_tokens", ["permanent"], name: "index_login_tokens_on_permanent", using: :btree
  add_index "login_tokens", ["token"], name: "index_login_tokens_on_token", using: :btree
  add_index "login_tokens", ["user_id"], name: "index_login_tokens_on_user_id", using: :btree

  create_table "month_athletes", force: true do |t|
    t.string   "name"
    t.integer  "month"
    t.integer  "year"
    t.integer  "picture_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repetitions", force: true do |t|
    t.string "times"
  end

  create_table "users", force: true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "login"
    t.datetime "last_login"
    t.integer  "permission"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facebook_id", limit: 8
    t.string   "password"
    t.string   "salt"
    t.string   "gender",      limit: 1
    t.date     "birthday"
  end

  create_table "users_exercises", force: true do |t|
    t.integer "user_id"
    t.integer "exercise_id"
  end

end
