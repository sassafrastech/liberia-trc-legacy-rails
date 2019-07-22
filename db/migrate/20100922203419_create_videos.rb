class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.integer :videoset_id
      t.integer :region_id
      t.string :title
      t.text :description
      t.string :quality
      t.date :recorded_on
      t.time :length
      t.integer :width
      t.integer :height
      t.integer :size
      t.string :youtube_id
      t.string :library_id
      t.string :library_alt_id
      t.string :library_stream_url
      t.string :library_dl_url
      t.integer :hearing_type_id
      t.string :speaker_fname
      t.string :speaker_lname

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
