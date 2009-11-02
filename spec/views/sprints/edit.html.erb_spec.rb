require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sprints/edit.html.erb" do
  include SprintsHelper

  before(:each) do
    assigns[:sprint] = @sprint = stub_model(Sprint,
      :new_record? => false,
      :title => "value for title",
      :theme => "value for theme",
      :number_of_days => 1
    )
  end

  it "renders the edit sprint form" do
    render

    response.should have_tag("form[action=#{sprint_path(@sprint)}][method=post]") do
      with_tag('input#sprint_title[name=?]', "sprint[title]")
      with_tag('input#sprint_theme[name=?]', "sprint[theme]")
    end
  end
end
