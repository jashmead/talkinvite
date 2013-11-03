require 'spec_helper'

describe "faqs/index" do
  before(:each) do
    assign(:faqs, [
      stub_model(Faq,
        :question => "MyQuestion1",
        :answer => "MyAnswer1"
      ),
      stub_model(Faq,
        :question => "MyQuestion2",
        :answer => "MyAnswer2"
      )
    ])
  end

  it "renders a list of faqs" do
    render
    assert_select "a", :content => /Question1/    # it's content for 'a', not 'text'
    assert_select "a", :content => /Question2/
    # TBD:  New Question should only appear if we are admin
    assert_select "a", :content => /New Question/
  end
end
