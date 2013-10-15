require 'spec_helper'

describe "venues/index" do
  before(:each) do
    assign(:venues, [
      stub_model(Venue,
        :person_id => 1,
        :name => "Name",
        :description => "MyText",
        :longitude => "9.99",
        :latitude => "8.88",
        :venue_type => "Venue Type"
      ),
      stub_model(Venue,
        :person_id => 1,
        :name => "Name",
        :description => "MyText",
        :longitude => "9.99",
        :latitude => "8.88",
        :venue_type => "Venue Type"
      )
    ])
  end

  it "renders a list of venues" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "8.88".to_s, :count => 2
    assert_select "tr>td", :text => "Venue Type".to_s, :count => 2
  end
end
