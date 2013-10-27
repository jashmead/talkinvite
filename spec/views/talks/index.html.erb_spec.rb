require 'spec_helper'

describe "talks/index" do

  subject { page }

  before(:each) do
    assign(:talks, [
      stub_model(Talk,
        :summary => "Summary1",
        :description => "MyText"
      ),
      stub_model(Talk,
        :summary => "Summary2",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of talks" do
    render
    # save_and_open_page
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "li", :text => "Summary1".to_s, :count => 1
    assert_select "li", :text => "Summary2".to_s, :count => 1
  end
end
