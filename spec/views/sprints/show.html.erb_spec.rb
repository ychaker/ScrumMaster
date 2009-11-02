require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sprints/show.html.erb" do
  include SprintsHelper
  before(:each) do
    assigns[:sprint] = @sprint = stub_model(Sprint,
      :title => "value for title",
      :theme => "value for theme",
      :start_date => "2009-10-31",
      :end_date => "2009-10-31",
      :number_of_days => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ title/)
    response.should have_text(/value\ for\ theme/)
    response.should have_text(/1/)
  end
end
