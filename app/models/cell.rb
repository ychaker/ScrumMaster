class Cell < ActiveRecord::Base
  belongs_to :task
  
  def after_update
    self.task.cells.select { |c| c.day > self.day }.each do
      |cell|
      cell.hours = self.hours 
      cell.save
    end
  end
end
