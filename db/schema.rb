# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100922203214) do

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "parent_id",   :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_items", :force => true do |t|
    t.string   "title"
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "album_id",   :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "press_releases", :force => true do |t|
    t.string   "title"
    t.string   "alias"
    t.date     "released_on"
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.string   "capital"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transcripts", :force => true do |t|
    t.string   "title"
    t.date     "recorded_on"
    t.integer  "region_id",    :limit => 11
    t.string   "municipality"
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videosets", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
