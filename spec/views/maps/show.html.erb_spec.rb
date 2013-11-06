require 'spec_helper'

describe "maps/show" do
  before(:each) do
    @map = assign(:map, stub_model(Map,
      :name => "Name",
      :description => "Description",
      :geometry => "MyGeometry",
      :settings => "MySettings",
      :history => "MyHistory"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
    rendered.should match(/MyGeometry/)
    rendered.should match(/MySettings/)
    rendered.should match(/MyHistory/)
  end
end
