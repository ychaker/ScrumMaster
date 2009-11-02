require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/index.html.erb" do
  include TasksHelper

  before(:each) do
    assigns[:tasks] = [
      stub_model(Task,
        :title => "value for title",
        :found => 1,
        :done => 1,
        :low_estimate => 1,
        :high_estimate => 1,
        :initial_estimate => 1,
        :sprint_id => 1
      ),
      stub_model(Task,
        :title => "value for title",
        :found => 1,
        :done => 1,
        :low_estimate => 1,
        :high_estimate => 1,
        :initial_estimate => 1,
        :sprint_id => 1
      )
    ]
  end

  it "renders a list of tasks" do
    render
    response.should have_tag("tr>td", "value for title".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
