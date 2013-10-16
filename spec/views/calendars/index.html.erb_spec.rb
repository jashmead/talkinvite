require 'spec_helper'

describe "calendars/index" do
  before(:each) do
    assign(:calendars, [
      stub_model(Calendar,
        :name => "Name",
        :description => "MyText",
        :chronometry => "MyChronometry",
        :settings => "MySettings",
        :history => "MyHistory"
      ),
      stub_model(Calendar,
        :name => "Name",
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
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyChronometry".to_s, :count => 2
    assert_select "tr>td", :text => "MySettings".to_s, :count => 2
    assert_select "tr>td", :text => "MyHistory".to_s, :count => 2
  end
end
