require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Cell do
  fixtures :sprints, :tasks
  
  before(:each) do
    @sprint1 = sprints(:one)
    
    @valid_attributes = {
      :day => Date.today,
      :hours => 1,
      :task_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Cell.create!(@valid_attributes)
  end
  
  it "should update following day's cell when updated" do
    task = Task.create!(:title => "value for title",:started => Time.now, :found => 1, :done => 1, :low_estimate => 2, :high_estimate => 5, :sprint_id => @sprint1.id)
    task.save
    task.cells.first.hours.should equal(4)
    cell = task.cells.first
    cell.hours = 2
    cell.save!
    task.cells.last.hours.should == 2
  end
end
