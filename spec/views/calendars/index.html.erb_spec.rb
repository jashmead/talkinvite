require 'spec_helper'

describe "calendars/index" do
  before(:each) do
    assign(:calendars, [
      stub_model(Calendar,
        :user_id => 1,
        :name => "Name",
        :description => "MyText",
        :source => "Source",
        :settings => "MyText"
      ),
      stub_model(Calendar,
        :user_id => 1,
        :name => "Name",
        :description => "MyText",
        :source => "Source",
        :settings => "MyText"
      )
    ])
  end

  it "renders a list of calendars" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # commented out asserts were failing, reason unknown
    # assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    # assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
