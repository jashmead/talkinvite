require 'spec_helper'

describe "socials/index" do
  before(:each) do
    assign(:socials, [
      stub_model(Social,
        :person_id => 1,
        :talk_id => 2,
        :social_type => "Social Type",
        :social_text => "MyText"
      ),
      stub_model(Social,
        :person_id => 1,
        :talk_id => 2,
        :social_type => "Social Type",
        :social_text => "MyText"
      )
    ])
  end

  it "renders a list of socials" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Social Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
