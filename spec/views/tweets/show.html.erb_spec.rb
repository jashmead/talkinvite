require 'spec_helper'

describe "tweets/show" do
  before(:each) do
    @tweet = assign(:tweet, stub_model(Tweet,
      :person_id => 1,
      :screen_name => "Screen Name",
      :content => "Content",
      :location_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Screen Name/)
    rendered.should match(/Content/)
    rendered.should match(/2/)
  end
end
