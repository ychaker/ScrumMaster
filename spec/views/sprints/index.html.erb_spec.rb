require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sprints/index.html.erb" do
  include SprintsHelper

  before(:each) do
    assigns[:sprints] = [
      stub_model(Sprint,
        :title => "value for title",
        :theme => "value for theme",
        :number_of_days => 1
      ),
      stub_model(Sprint,
        :title => "value for title",
        :theme => "value for theme",
        :number_of_days => 1
      )
    ]
  end

  it "renders a list of sprints" do
    render
    response.should have_tag("tr>td", "value for title".to_s, 2)
    response.should have_tag("tr>td", "value for theme".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
