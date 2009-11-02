require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sprint do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :theme => "value for theme",
      :start_date => Date.today,
      :end_date => Date.today,
      :number_of_days => 1
    }
    
    @invalid_attributes = {
      :title => "value for title",
      :theme => "value for theme",
      :start_date => Date.today,
      :end_date => (Date.today - 1),
      :number_of_days => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Sprint.create!(@valid_attributes)
  end
  
  it "should not create a new instance given invalid attributes" do
    Sprint.create(@invalid_attributes).should_not be_valid
  end
  
  it "should get a list of all distinct users without nil users" do
    sprint1 = Factory.create(:sprint)
    task1 = Factory.create(:task, :id => 1, :sprint_id => sprint1.id)
    task2 = Factory.create(:task, :id => 2, :sprint_id => sprint1.id)
    task3 = Factory.create(:task, :id => 3, :sprint_id => sprint1.id)
    user1 = Factory.create(:user)
    user1.tasks << task1
    user1.tasks << task3
    
    sprint1.sprint_users.length.should == 1
  end
  
  it "should get a list of all distinct users" do
    sprint1 = Factory.create(:sprint)
    task1 = Factory.create(:task, :id => 1, :sprint_id => sprint1.id)
    task2 = Factory.create(:task, :id => 2, :sprint_id => sprint1.id)
    task3 = Factory.create(:task, :id => 3, :sprint_id => sprint1.id)
    user1 = Factory.create(:user)
    user1.tasks << task1
    user1.tasks << task3
    user2 = Factory.create(:user)
    user2.tasks << task2
    
    sprint1.sprint_users.length.should == 2
  end
end
