class CreateCells < ActiveRecord::Migration
  def self.up
    create_table :cells do |t|
      t.date :day
      t.integer :hours
      t.integer :task_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cells
  end
end
