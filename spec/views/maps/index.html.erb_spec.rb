require 'spec_helper'

describe "maps/index" do
  before(:each) do
    assign(:maps, [
      stub_model(Map,
        :name => "Name1",
        :description => "Legend",
        :geometry => "geometry",
        :settings => "settings",
        :history => "history"
      ),
      stub_model(Map,
        :name => "Name2",
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
    assert_select "a", :content => /Map1/    # it's content for 'a', not 'text'
    assert_select "a", :content => /Map2/
    assert_select "a", :content => /New Map/
  end
end
