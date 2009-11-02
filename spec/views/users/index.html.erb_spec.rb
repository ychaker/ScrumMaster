require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/index.html.erb" do
  include UsersHelper

  before(:each) do
    assigns[:users] = [
      stub_model(User,
        :name => "value for name",
        :initials => "value for initials"
      ),
      stub_model(User,
        :name => "value for name",
        :initials => "value for initials"
      )
    ]
  end

  it "renders a list of users" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for initials".to_s, 2)
  end
end
