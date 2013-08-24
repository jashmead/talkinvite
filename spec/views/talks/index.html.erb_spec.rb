require 'spec_helper'

describe "talks/index" do
  before(:each) do
    assign(:talks, [
      stub_model(Talk,
        :summary => "Summary",
        :description => "MyText",
        :location_id => 1
      ),
      stub_model(Talk,
        :summary => "Summary",
        :description => "MyText",
        :location_id => 1
      )
    ])
  end

  it "renders a list of talks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
