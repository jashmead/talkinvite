require 'spec_helper'

describe "credits/show" do
  before(:each) do
    @credit = assign(:credit, stub_model(Credit,
      :worthy_one => "MyText",
      :service_supplied => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
