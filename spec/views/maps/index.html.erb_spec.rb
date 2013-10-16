require 'spec_helper'

describe "maps/index" do
  before(:each) do
    assign(:maps, [
      stub_model(Map,
        :name => "Name",
        :description => "Legend",
        :geometry => "geometry",
        :settings => "settings",
        :history => "history"
      ),
      stub_model(Map,
        :name => "Name",
        :description => "Legend",
        :geometry => "geometry",
        :settings => "settings",
        :history => "history"
      )
    ])
  end

  it "renders a list of maps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Legend".to_s, :count => 2
    assert_select "tr>td", :text => "geometry".to_s, :count => 2
    assert_select "tr>td", :text => "settings".to_s, :count => 2
    assert_select "tr>td", :text => "history".to_s, :count => 2
  end
end
