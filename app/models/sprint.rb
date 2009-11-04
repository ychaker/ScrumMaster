require "rubygems"
require "gchart"

class Sprint < ActiveRecord::Base
  
  has_many :tasks
  has_many :users, :through => :tasks, :uniq => true
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
  
  def actual
    [self.initial_sum] + self.sum_per_day
  end

  
  ###########################
  # Burndown
  ###########################
  def burndown
    workdays = self.workdays
    today = workdays.include?(Date.today) ? workdays.index(Date.today) : 1
    chart = GChart.line do |g|
      g.data   = [self.low_estimate,  self.high_estimate, self.two_thirds_estimate, self.actual]
      g.colors = [:green,             :red,               :yellow,                  :blue]
      g.legend = ["Low",              "High",             "2/3",                    "Actual"]
      g.extras = { "chm" => "R,A0BAE9,0," + (1.0*today/workdays.length).to_s + "," + (1.0*today/workdays.length+0.01).to_s + "|o,0066FF,0,-1,6|o,0066FF,1,-1,6|o,0066FF,2,-1,6|o,0066FF,3,-1,6" }

      g.width             = 800
      g.height            = 300
      g.entire_background = "f4f4f4"

      g.axis :left do |a| 
        a.range = 0..[self.high_estimate.max, self.actual.max].max
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
  
  def flash_burndown
    title = Title.new("Burndown")
    data1 = self.low_estimate
    data2 = self.high_estimate
    data3 = self.two_thirds_estimate
    data4 = self.actual

    line1 = LineDot.new
    line1.text = "Low Estimates"
    line1.width = 1
    line1.colour = '#00ff00'
    line1.dot_size = 5
    line1.values = data1

    line2 = LineDot.new
    line2.text = "High Estimates"
    line2.width = 1
    line2.colour = 'ff0000'
    line2.dot_size = 5
    line2.values = data2

    line3 = LineDot.new
    line3.text = "2/3 Estimates"
    line3.width = 1
    line3.colour = '#F0F000'
    line3.dot_size = 5
    line3.values = data3

    line4 = LineDot.new
    line4.text = "Actual"
    line4.width = 1
    line4.colour = '#0000ff'
    line4.dot_size = 5
    line4.values = data4

    y = YAxis.new
    y.set_range(0,[data2.max, data4.max].max,5)

    workdays = self.workdays.collect { |day| day.to_s(:short) }
    tmp = []
    x_labels = XAxisLabels.new
    x_labels.set_vertical()

    workdays.each do |text|
      tmp << XAxisLabel.new(text, '#0000ff', 12, 'diagonal')
    end

    x_labels.labels = tmp

    x = XAxis.new
    x.set_labels(x_labels)

    x_legend = XLegend.new("Days")
    x_legend.set_style('{font-size: 20px; color: #778877}')

    y_legend = YLegend.new("Hours")
    y_legend.set_style('{font-size: 20px; color: #770077}')

    chart =OpenFlashChart.new
    chart.set_title(title)
    chart.set_x_legend(x_legend)
    chart.set_y_legend(y_legend)
    chart.y_axis = y
    chart.x_axis = x

    chart.add_element(line1)
    chart.add_element(line2)
    chart.add_element(line3)
    chart.add_element(line4)

    chart
  end
end
