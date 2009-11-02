class AddSprintTaskRelationship < ActiveRecord::Migration
  def self.up
    add_column :tasks, :sprint_id, :integer
  end

  def self.down
    remove_column :tasks, :sprint_id
  end
end
