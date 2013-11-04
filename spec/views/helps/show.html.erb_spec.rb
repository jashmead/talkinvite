require 'spec_helper'

describe "helps/show" do
  before(:each) do
    @faq = assign(:faq, stub_model(Faq,
      :name => "Myname",
      :description => "MyDescription"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Myname/)
    rendered.should match(/MyDescription/)
  end
end

