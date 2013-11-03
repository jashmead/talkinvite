require 'spec_helper'

describe "faqs/show" do
  before(:each) do
    @faq = assign(:faq, stub_model(Faq,
      :question => "MyQuestion",
      :answer => "MyAnswer"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyQuestion/)
    rendered.should match(/MyAnswer/)
  end
end
