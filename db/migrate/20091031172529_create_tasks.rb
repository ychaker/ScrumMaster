class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :title
      t.date :started
      t.boolean :found
      t.boolean :done
      t.integer :low_estimate
      t.integer :high_estimate
      t.integer :initial_estimate

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
