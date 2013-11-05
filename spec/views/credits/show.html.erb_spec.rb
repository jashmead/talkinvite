require 'spec_helper'

describe "credits/show" do
  before(:each) do
    @credit = assign(:credit, stub_model(Credit,
      :name => "Worthy",
      :description => "Meritorious Act"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Worthy/)
    rendered.should match(/Meritorious Act/)
  end
end

