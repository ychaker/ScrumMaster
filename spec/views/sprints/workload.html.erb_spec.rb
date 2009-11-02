require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sprints/workload.html.erb" do
  include SprintsHelper
  before(:each) do
    assigns[:sprint] = @sprint = Factory.create(:sprint)
    @task1 = Factory.create(:task, :sprint_id => @sprint.id)
    @user = Factory.create(:user)
    @user.tasks << @task1
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/UN/)
    response.should have_text(/2/)
  end
end
