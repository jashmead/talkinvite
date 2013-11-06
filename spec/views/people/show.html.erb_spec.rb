require 'spec_helper'

describe "people/show" do
  before(:each) do
    @person = assign(:person, stub_model(Person,
      :name => "MyName",
      :email => "name@email.com",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    # rendered.should match(/MyName/)           # name not appearing?
    rendered.should match(/Description/)
    rendered.should_not match(/name@email.com/)  # email should not show on profile page!
  end
end
