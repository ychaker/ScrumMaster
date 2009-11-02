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
end
