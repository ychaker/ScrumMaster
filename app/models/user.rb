class User < ActiveRecord::Base
  has_many :tasks
  
  def sprint_initial_workload sprint_id
    tasks = self.tasks.select { |t| t.sprint_id == sprint_id }
    tasks.inject(0){|sum,item| sum + item.initial_estimate}
  end
  
  def sprint_remaining_workload sprint_id
    tasks = self.tasks.select { |t| t.sprint_id == sprint_id }
    tasks.inject(0){|sum,item| sum + item.cells.last.hours}
  end
end
