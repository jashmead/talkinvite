require 'spec_helper'

describe "credits/index" do
  before(:each) do
    assign(:credits, [
      stub_model(Credit,
        :name => "Lad A",
        :description => "Service A"
      ),
      stub_model(Credit,
        :name => "Lass B",
        :description => "Service B"
      )
    ])
  end

  it "renders a list of credits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "li", :text => /Lad A/, count: 1
    assert_select "li",:text => /Lass B/, count: 1
  end

  # what is test for admin? in spec arena?
  it "only shows new button if you are an admin" do
    pending "No New if not admin"
    pending "New if admin"
  end

end
