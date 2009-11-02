require "rubygems"
require "gchart"

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
  
  ###########################
  # Sums and estimates
  ###########################
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
  
  
  ###########################
  # Users
  ###########################
  def sprint_users
    all = []
    self.tasks.each { 
      |t| 
      all << t.user unless t.user.nil? 
    }
    all.uniq
  end
  
  ###########################
  # Burndown
  ###########################
  def burndown
    workdays = self.workdays
    today = workdays.include?(Date.today) ? workdays.index(Date.today) : 1
    chart = GChart.line do |g|
      g.data   = [self.low_estimate,  self.high_estimate, self.two_thirds_estimate, self.sum_per_day]
      g.colors = [:green,             :red,               :yellow,                  :blue]
      g.legend = ["Low",              "High",             "2/3",                    "Actual"]
      g.extras = { "chm" => "R,A0BAE9,0," + (1.0*today/workdays.length).to_s + "," + (1.0*today/workdays.length+0.01).to_s + "|o,0066FF,0,-1,6|o,0066FF,1,-1,6|o,0066FF,2,-1,6|o,0066FF,3,-1,6" }

      g.width             = 800
      g.height            = 300
      g.entire_background = "f4f4f4"

      g.axis :left do |a| 
        a.range = 0..self.high_estimate.max
        a.labels = self.high_estimate.sort
        a.text_color      = :black
      end

      g.axis :bottom do |a|
        a.labels          = workdays.collect { |day| day.to_s(:short) }
        a.text_color      = :black
      end

      g.axis :bottom do |a|
        a.labels          = ["Days"]
        a.label_positions = [50]
      end
      
      g.axis :left do |a|
        a.labels          = ["Hours"]
        a.label_positions = [50]
      end
    end
    chart
  end
end
