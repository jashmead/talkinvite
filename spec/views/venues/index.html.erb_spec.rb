require 'spec_helper'

describe "venues/index" do
  before(:each) do
    assign(:venues, [
      stub_model(Venue,
        :person_id => 1,
        :name => "Name1",
        :description => "MyText",
        :longitude => "9.99",
        :latitude => "8.88",
        :venue_type => "Venue Type"
      ),
      stub_model(Venue,
        :person_id => 1,
        :name => "Name2",
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
    assert_select "a", :content => /Name1/    # it's content for 'a', not 'text'
    assert_select "a", :content => /Name2/
    assert_select "a", :content => /New Venue/
  end
end
