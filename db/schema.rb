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

ActiveRecord::Schema.define(version: 20131116180001) do

  create_table "blog_comments", force: true do |t|
    t.integer  "post_id",                      null: false
    t.integer  "author_id",                    null: false
    t.text     "content"
    t.boolean  "is_published", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blog_comments", ["post_id", "created_at"], name: "index_blog_comments_on_post_id_and_created_at", using: :btree
  add_index "blog_comments", ["post_id", "is_published", "created_at"], name: "index_blog_comments_on_post_published_created", using: :btree

  create_table "blog_posts", force: true do |t|
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

  add_index "blog_posts", ["created_at"], name: "index_blog_posts_on_created_at", using: :btree
  add_index "blog_posts", ["is_published", "created_at"], name: "index_blog_posts_on_is_published_and_created_at", using: :btree
  add_index "blog_posts", ["is_published", "year", "month", "slug"], name: "index_blog_posts_on_published_year_month_slug", using: :btree

  create_table "blog_taggings", force: true do |t|
    t.integer "post_id", null: false
    t.integer "tag_id",  null: false
  end

  add_index "blog_taggings", ["post_id", "tag_id"], name: "index_blog_taggings_on_post_tag", unique: true, using: :btree

  create_table "blog_tags", force: true do |t|
    t.string  "name",                           null: false
    t.boolean "is_category",    default: false, null: false
    t.integer "taggings_count", default: 0,     null: false
  end

  add_index "blog_tags", ["name", "taggings_count"], name: "index_blog_tags_on_name_and_taggings_count", unique: true, using: :btree
  add_index "blog_tags", ["taggings_count"], name: "index_blog_tags_on_taggings_count", using: :btree

  create_table "blogs", force: true do |t|
    t.integer "site_id",                             null: false
    t.string  "label",                               null: false
    t.string  "identifier",                          null: false
    t.string  "app_layout",  default: "application", null: false
    t.string  "path"
    t.text    "description"
  end

  add_index "blogs", ["identifier"], name: "index_blogs_on_identifier", using: :btree
  add_index "blogs", ["site_id", "path"], name: "index_blogs_on_site_id_and_path", using: :btree

  create_table "carousel_carousels", force: true do |t|
    t.string   "label",      null: false
    t.string   "identifier", null: false
    t.string   "dimensions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carousel_carousels", ["identifier"], name: "index_carousel_carousels_on_identifier", using: :btree

  create_table "carousel_slides", force: true do |t|
    t.integer  "carousel_id",                   null: false
    t.string   "label",                         null: false
    t.text     "content"
    t.string   "url"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.integer  "position",          default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carousel_slides", ["carousel_id", "position"], name: "index_carousel_slides_on_carousel_id_and_position", using: :btree

  create_table "cms_blocks", force: true do |t|
    t.integer  "page_id",                     null: false
    t.string   "identifier",                  null: false
    t.text     "content",    limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
