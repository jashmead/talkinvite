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
    rendered.should match(/Lad A/)
    rendered.should match(/Lass B/)
    # having troubling getting more complex HTML matchers to work:  http://api.rubyonrails.org/classes/HTML/Selector.html
    # i.e. "li a", "li > a", "li + a", "li~a"; "li,a" works, but of course!
    assert_select "a", :content => /Lad A/    # it's content for 'a', not 'text'
    assert_select "a", :content => /Lass B/
  end

  # what is test for admin? in spec arena?
  it "only shows new button if you are an admin" do
    pending "No New if not admin"
    pending "New if admin"
  end

end
