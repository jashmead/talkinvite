require 'spec_helper'

describe "maps/show" do
  before(:each) do
    @map = assign(:map, stub_model(Map,
      :user_id => 1,
      :name => "Name",
      :description => "MyText",
      :location_id => 2,
      :source => "MyText",
      :settings => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/MyText/) # for description
    rendered.should match(/2/)
    rendered.should match(/MyText/) # for source
    rendered.should match(/MyText/) # for settings
  end
end
