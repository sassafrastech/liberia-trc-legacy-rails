class CreateHearingTypes < ActiveRecord::Migration
  def self.up
    create_table :hearing_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hearing_types
  end
end
