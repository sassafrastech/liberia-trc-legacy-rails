class CreatePressReleases < ActiveRecord::Migration
  def self.up
    create_table :press_releases do |t|
      t.string :title
      t.string :alias
      t.date :released_on
      t.text :contents

      t.timestamps
    end
  end

  def self.down
    drop_table :press_releases
  end
end
