require 'spec_helper'

describe "talks/index" do

  subject { page }

  before(:each) do
    assign(:talks, [
      stub_model(Talk,
        :summary => "Summary",
        :description => "MyText"
      ),
      stub_model(Talk,
        :summary => "Summary",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of talks" do
    render
    # save_and_open_page
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
