class CreateTranscripts < ActiveRecord::Migration
  def self.up
    create_table :transcripts do |t|
      t.string :title
      t.date :recorded_on
      t.integer :region_id
      t.string :municipality
      t.text :contents

      t.timestamps
    end
  end

  def self.down
    drop_table :transcripts
  end
end
