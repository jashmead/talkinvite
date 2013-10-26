require 'spec_helper'

describe "calendars/index" do
  before(:each) do
    assign(:calendars, [
      stub_model(Calendar,
        :name => "Name1",
        :description => "MyText",
        :chronometry => "MyChronometry",
        :settings => "MySettings",
        :history => "MyHistory"
      ),
      stub_model(Calendar,
        :name => "Name2",
        :description => "MyText",
        :chronometry => "MyChronometry",
        :settings => "MySettings",
        :history => "MyHistory"
      )
    ])
  end

  it "renders a list of calendars" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "a", :content => 'MyName1'
    assert_select "a", :content => 'MyName2'
    assert_select "a", :content => 'New Attachment'
  end
end
