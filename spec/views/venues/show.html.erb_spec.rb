require 'spec_helper'

describe "venues/show" do
  before(:each) do
    @venue = assign(:venue, stub_model(Venue,
      :person_id => 1,
      :name => "Name",
      :description => "MyText",
      :longitude => "9.99",
      :latitude => "9.99",
      :venue_type => "Venue Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/Venue Type/)
  end
end
