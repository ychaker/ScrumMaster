require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sprints/new.html.erb" do
  include SprintsHelper

  before(:each) do
    assigns[:sprint] = stub_model(Sprint,
      :new_record? => true,
      :title => "value for title",
      :theme => "value for theme",
      :number_of_days => 1
    )
  end

  it "renders new sprint form" do
    render

    response.should have_tag("form[action=?][method=post]", sprints_path) do
      with_tag("input#sprint_title[name=?]", "sprint[title]")
      with_tag("input#sprint_theme[name=?]", "sprint[theme]")
    end
  end
end
