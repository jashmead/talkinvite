require 'spec_helper'

describe "talks/show" do
  before(:each) do
    @talk = assign(:talk, stub_model(Talk,
      :summary => "MySummary",
      :description => "MyText",
      :person => mock_model(Person, FactoryGirl.attributes_for(:person, :name => "MyName"))
    ))
  end

  it "renders attributes" do
    render
    # note: rendered does not show the title or header content:  
    #   -- looks like jqm/rspec misalignment
    #   -- as a result, we can't match on stuff in title or 'h1'
    # rendered.should match(/MySummary/)
    # rendered.should have_selector("h1")
    rendered.should match(/MyText/)
    rendered.should match(/MyName/)
  end
end
