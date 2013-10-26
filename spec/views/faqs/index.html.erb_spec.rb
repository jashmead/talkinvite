require 'spec_helper'

describe "faqs/index" do
  before(:each) do
    assign(:faqs, [
      stub_model(Faq,
        :question => "MyQuestion1",
        :answer => "MyAnswer"
      ),
      stub_model(Faq,
        :question => "MyQuestion2",
        :answer => "MyAnswer"
      )
    ])
  end

  it "renders a list of faqs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "a", :content => /Question1/    # it's content for 'a', not 'text'
    assert_select "a", :content => /Question2/
    assert_select "a", :content => /New Question/
  end
end
