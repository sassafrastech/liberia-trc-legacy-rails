class CreateVideosets < ActiveRecord::Migration
  def self.up
    create_table :videosets do |t|
      t.string :title
      t.string :name
      t.string :description
      t.integer :cover_id
      

      t.timestamps
    end
  end

  def self.down
    drop_table :videosets
  end
end
