require 'spec_helper'

describe "ads/index" do
  before(:each) do
    assign(:ads, [
      stub_model(Ad,
        :name => "MyName",
        :description => "MyDescription",
        :internal_flag => true,
        :content => "MyContent",
        :source => "MySource",
        :strategy => "MyStrategy",
        :stats => "MyStats"
      ),
      stub_model(Ad,
        :name => "MyName",
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
    assert_select "tr>td", :text => "MyName".to_s, :count => 2
    assert_select "tr>td", :text => "MyDescription".to_s, :count => 2
    assert_select "tr>td", :text => true.to_s, :count => 2
    assert_select "tr>td", :text => "MyContent".to_s, :count => 2
    assert_select "tr>td", :text => "MySource".to_s, :count => 2
    assert_select "tr>td", :text => "MyStrategy".to_s, :count => 2
    assert_select "tr>td", :text => "MyStats".to_s, :count => 2
  end
end
