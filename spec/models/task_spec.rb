require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Task do
  fixtures :sprints
  
  before(:each) do
    @sprint1 = sprints(:one)  
    @valid_attributes = {
      :title => "value for title",
      :started => Date.today,
      :found => 1,
      :done => 1,
      :low_estimate => 1,
      :high_estimate => 1,
      :initial_estimate => 1,
      :sprint_id => @sprint1.id
    }
  end

  it "should create a new instance given valid attributes" do
    Task.create!(@valid_attributes)
  end
end
