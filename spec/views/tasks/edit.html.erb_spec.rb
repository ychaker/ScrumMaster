require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/edit.html.erb" do
  include TasksHelper

  before(:each) do
    assigns[:task] = @task = stub_model(Task,
      :new_record? => false,
      :title => "value for title",
      :found => 1,
      :done => 1,
      :low_estimate => 1,
      :high_estimate => 1,
      :initial_estimate => 1,
      :sprint_id => 1
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

  it "renders the edit task form" do
    render

    response.should have_tag("form[action=#{task_path(@task)}][method=post]") do
      with_tag('input#task_title[name=?]', "task[title]")
      with_tag('input#task_found[name=?]', "task[found]")
      with_tag('input#task_done[name=?]', "task[done]")
      with_tag('select#task_low_estimate[name=?]', "task[low_estimate]")
      with_tag('select#task_high_estimate[name=?]', "task[high_estimate]")
    end
  end
end
