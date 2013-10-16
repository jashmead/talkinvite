require 'spec_helper'

describe "ads/show" do
  before(:each) do
    @ad = assign(:ad, stub_model(Ad,
      :name => "",
      :description => "MyText",
      :internal_flag => false,
      :content => "MyText",
      :source => "MyText",
      :strategy => "MyText",
      :stats => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
