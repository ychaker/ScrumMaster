class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.string :title
      t.string :theme
      t.date :start_date
      t.date :end_date
      t.integer :number_of_days

      t.timestamps
    end
  end

  def self.down
    drop_table :sprints
  end
end
