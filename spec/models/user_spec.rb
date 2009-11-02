require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  fixtures :sprints, :tasks, :users
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :initials => "value for initials"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
  
  it "should calculate sprint workload" do
    sprint1 = Factory.create(:sprint)
    task1 = Factory.create(:task, :id => 1, :sprint_id => sprint1.id)
    task2 = Factory.create(:task, :id => 2, :sprint_id => sprint1.id)
    user = Factory.create(:user)
    user.tasks << task1
    
    user.sprint_initial_workload(sprint1.id).should == 2
    
    task3 = Factory.create(:task, :id => 3, :sprint_id => sprint1.id, :low_estimate => "5", :high_estimate => "8")
    user.tasks << task3
    
    user.sprint_initial_workload(sprint1.id).should == 9
    
    user.sprint_remaining_workload(sprint1.id). should == 9
    
    last = task3.cells.last
    last.hours = 3
    last.save
    
    user.sprint_remaining_workload(sprint1.id). should == 5
  end
end
