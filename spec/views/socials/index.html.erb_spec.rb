require 'spec_helper'

describe "socials/index" do
  before(:each) do
    assign(:socials, [
      stub_model(Social,
        :person_id => 1,
        :talk_id => 2,
        :social_type => "Social Type",
        :social_text => "MyText1"
      ),
      stub_model(Social,
        :person_id => 1,
        :talk_id => 2,
        :social_type => "Social Type",
        :social_text => "MyText2"
      )
    ])
  end

  it "renders a list of socials" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "a", :content => /MyText1/    # it's content for 'a', not 'text'
    assert_select "a", :content => /MyText2/
    assert_select "a", :content => /New Social/
  end
end
