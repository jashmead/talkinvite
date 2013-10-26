require 'spec_helper'

describe "ads/index" do
  before(:each) do
    assign(:ads, [
      stub_model(Ad,
        :name => "MyName1",
        :description => "MyDescription",
        :internal_flag => true,
        :content => "MyContent",
        :source => "MySource",
        :strategy => "MyStrategy",
        :stats => "MyStats"
      ),
      stub_model(Ad,
        :name => "MyName2",
        :description => "MyDescription",
        :internal_flag => true,
        :content => "MyContent",
        :source => "MySource",
        :strategy => "MyStrategy",
        :stats => "MyStats"
      )
    ])
  end

  it "renders a list of ads" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "a", :content => 'MyName1'
    assert_select "a", :content => 'MyName2'
    assert_select "a", :content => 'New Ad'
  end
end
