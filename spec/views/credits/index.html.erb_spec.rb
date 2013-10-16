require 'spec_helper'

describe "credits/index" do
  before(:each) do
    assign(:credits, [
      stub_model(Credit,
        :worthy_one => "MyWorthiness",
        :service_supplied => "TheServiceSupplied"
      ),
      stub_model(Credit,
        :worthy_one => "MyWorthiness",
        :service_supplied => "TheServiceSupplied"
      )
    ])
  end

  it "renders a list of credits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyWorthiness".to_s, :count => 2
    assert_select "tr>td", :text => "TheServiceSupplied".to_s, :count => 2
  end
end
