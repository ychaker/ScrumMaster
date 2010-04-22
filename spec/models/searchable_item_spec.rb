require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchableItem do
  before(:each) do
    @valid_attributes = {
      :model => "value for model",
      :field => "value for field",
      :type => "value for type"
    }
  end

  it "should create a new instance given valid attributes" do
    SearchableItem.create!(@valid_attributes)
  end
end
