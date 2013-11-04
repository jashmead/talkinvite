require 'spec_helper'

describe "credits/index" do
  before(:each) do
    assign(:credits, [
      stub_model(Credit,
        :question => "MyName1",
        :description => "MyDescription1"
      ),
      stub_model(Credit,
        :question => "MyName2",
        :description => "MyDescription2"
      )
    ])
  end

  it "renders a list of credits" do
    render
    assert_select "a", :content => /Name1/    # it's content for 'a', not 'text'
    assert_select "a", :content => /Name2/
    # TBD:  New Name should only appear if we are admin
    assert_select "a", :content => /New Name/
  end
end

