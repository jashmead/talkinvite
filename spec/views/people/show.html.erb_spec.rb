require 'spec_helper'

describe "people/show" do
  before(:each) do
    @person = assign(:person, stub_model(Person,
      :name => "Name",
      :email => "Email",
      :about_me => "MyText",
      :screen_name => "Screen Name",
      :settings => "Settings"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Email/)
    rendered.should match(/MyText/)
    rendered.should match(/Screen Name/)
    rendered.should match(/Settings/)
  end
end
