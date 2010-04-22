class Task < ActiveRecord::Base
  belongs_to :sprint
  has_many :cells, :order => "day ASC"
  belongs_to :user
  validates_presence_of :title
  validates_numericality_of :low_estimate, :high_estimate, :initial_estimate
  
  named_scope :ordered, lambda {|*args| {:order => (args.first || 'title ASC')} }

  def before_validation
    self.initial_estimate = 0.33*self.low_estimate + 0.67*self.high_estimate
  end
  
  def after_create
    for day in self.sprint.workdays
      cell = Cell.new(:day => day, :hours => self.initial_estimate, :task_id => self.id)
      cell.save
    end
  end
end
