require 'spec_helper'

describe "people/index" do
  before(:each) do
    assign(:people, [
      stub_model(Person,
        :name => "Name",
        :email => "Email"
      ),
      stub_model(Person,
        :name => "Name",
        :email => "Email"
      )
    ])
  end

## TBD: this is expecting an '@test' variable, of which we know nothing... -- fix
=begin
  it "renders a list of people" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    ## assert_select "li", :text => "Name".to_s
    ## assert_select "li", :text => "Email".to_s
    ##	assert_select "tr>td", :text => "Name".to_s, :count => 2
    ##	assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
=end

end
