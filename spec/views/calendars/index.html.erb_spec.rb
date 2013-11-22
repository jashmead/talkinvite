require 'spec_helper'

describe "calendars/index" do
  before(:each) do
    assign(:calendars, [
      stub_model(Calendar,
        :person_id => 1,
        :talk_id => 2,
        :name => "MyCalendar1"
      ),
      stub_model(Calendar,
        :person_id => 1,
        :talk_id => 2,
        :name => "MyCalendar2"
      )
    ])
  end

  it "renders a list of calendars" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "a", :content => 'MyCalendar1'
    assert_select "a", :content => 'MyCalendar2'
    assert_select "a", :content => 'New Calendar'
  end
end
