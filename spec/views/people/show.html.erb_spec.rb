require 'spec_helper'

describe "people/show" do
  before(:each) do
    @person = assign(:person, stub_model(Person,
      :name => "Name",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Email/)
  end
end

## looking for person #0 is triggering an error before we can trap it
##  resolve this, then turn this test back on
=begin
describe "people/noshow" do
  before do
    visit '/people/0'
  end

  it "on noshow, switch to 'search' page" do
  end
end
=end
