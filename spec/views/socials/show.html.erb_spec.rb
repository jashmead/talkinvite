require 'spec_helper'

describe "socials/show" do
  before(:each) do
    @social = assign(:social, stub_model(Social,
      :person_id => 1,
      :talk_id => 2,
      :social_type => "Social Type",
      :social_text => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Social Type/)
    rendered.should match(/MyText/)
  end
end
