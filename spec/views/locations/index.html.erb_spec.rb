require 'spec_helper'

describe "locations/index" do
  before(:each) do
    assign(:locations, [
      stub_model(Location,
        :name => "Name",
        :description => "Description",
        :longitude => 1.5,
        :latitude => 1.5,
        :address => "Address"
      ),
      stub_model(Location,
        :name => "Name",
        :description => "Description",
        :longitude => 1.5,
        :latitude => 1.5,
        :address => "Address"
      )
    ])
  end

  it "renders a list of locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
  end
end
