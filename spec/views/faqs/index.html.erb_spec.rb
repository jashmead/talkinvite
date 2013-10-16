require 'spec_helper'

describe "faqs/index" do
  before(:each) do
    assign(:faqs, [
      stub_model(Faq,
        :question => "MyQuestion",
        :answer => "MyAnswer"
      ),
      stub_model(Faq,
        :question => "MyQuestion",
        :answer => "MyAnswer"
      )
    ])
  end

  it "renders a list of faqs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyQuestion".to_s, :count => 2
    assert_select "tr>td", :text => "MyAnswer".to_s, :count => 2
  end
end
