require 'spec_helper'

describe "people/index" do
  before(:each) do
    assign(:people, [
      stub_model(Person,
        :name => "Name1",
        :email => "Email",
        :description => "Description"
      ),
      stub_model(Person,
        :name => "Name2",
        :email => "Email",
        :description => "Description"
      )
    ])
  end

  it "renders a list of people" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "li", :text => "Name1".to_s
    assert_select "li", :text => "Name2".to_s
  end

end
