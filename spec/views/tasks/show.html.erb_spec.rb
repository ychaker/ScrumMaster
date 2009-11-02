require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/show.html.erb" do
  include TasksHelper
  before(:each) do
    assigns[:task] = @task = stub_model(Task,
      :title => "value for title",
      :found => 1,
      :done => 1,
      :low_estimate => 1,
      :high_estimate => 1,
      :initial_estimate => 1
    )
    assigns[:sprint] = @sprint = stub_model(Sprint,
      :new_record? => false,
      :title => "value for title",
      :theme => "value for theme",
      :number_of_days => 1,
      :id => 1
    )
    @task.sprint = @sprint
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ title/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end
