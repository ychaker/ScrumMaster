class Sprint < ActiveRecord::Base
  has_many :tasks
  validate :end_date_greater
  
  def end_date_greater
    errors.add_to_base("End date must be greater or equal to start date") unless (end_date >= start_date)
  end
  
  
  def before_save
    self.number_of_days = self.workdays.length
  end
  
  def workdays
    (self.start_date..self.end_date).reject { |d| [0,6].include? d.wday } 
  end
  
  def initial_sum
    self.tasks.inject(0){|sum,item| sum + item.initial_estimate}
  end
  
  def low_sum
    self.tasks.inject(0){|sum,item| sum + item.low_estimate}
  end
  
  def high_sum
    self.tasks.inject(0){|sum,item| sum + item.high_estimate}
  end
  
  def two_thirds_estimate
    array = []
    array << self.initial_sum
    (1..self.number_of_days).each {
      num = (array.last - (1.0*array.first/self.number_of_days)).to_i
      array << (num > 0 ? num : 0)
    }
    array
  end
  
  def low_estimate
    array = []
    array << self.low_sum
    initial = self.initial_sum
    (1..self.number_of_days).each {
      num = (array.last - (1.0*initial/self.number_of_days)).to_i
      array << (num > 0 ? num : 0)
    }
    array
  end
  
  def high_estimate
    array = []
    array << self.high_sum
    initial = self.low_sum
    (1..self.number_of_days).each {
      num = (array.last - (1.0*initial/self.number_of_days)).to_i
      array << (num > 0 ? num : 0)
    }
    array
  end
  
  def sum_per_day
    sum = []
    self.workdays.each do
      |workday|
      sum << self.tasks.inject(0) { 
        |day_sum,t| 
        day_sum += t.cells.select { |c| c.day == workday }.first.hours
      }
    end
    sum
  end
end
