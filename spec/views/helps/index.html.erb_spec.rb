require 'spec_helper'

describe "helps/index" do
  before(:each) do
    assign(:helps, [
      stub_model(Help,
        :question => "MyName1",
        :description => "MyDescription1"
      ),
      stub_model(Help,
        :question => "MyName2",
        :description => "MyDescription2"
      )
    ])
  end

  it "renders a list of helps" do
    render
    assert_select "a", :content => /Name1/    # it's content for 'a', not 'text'
    assert_select "a", :content => /Name2/
    # TBD:  New Name should only appear if we are admin
    assert_select "a", :content => /New Name/
  end
end

