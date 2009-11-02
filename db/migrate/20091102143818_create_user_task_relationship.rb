class CreateUserTaskRelationship < ActiveRecord::Migration
  def self.up
    add_column :tasks, :user_id, :integer
  end

  def self.down
    remove :tasks, :user_id
  end
end
