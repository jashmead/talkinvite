require 'spec_helper'

describe "calendars/show" do
  before(:each) do
    @calendar = assign(:calendar, stub_model(Calendar,
      :person_id => 1,
      :talk_id => 2,
      :name => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
  end
end
