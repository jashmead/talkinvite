require 'spec_helper'

describe "helps/index" do
  before(:each) do
    assign(:helps, [
      stub_model(Help,
        :name => "Name1",
        :title => "Help Title1",
        :description => "MyText1",
        :help_type => "page"
      ),
      stub_model(Help,
        :name => "Name1",
        :title => "Help Title2",
        :description => "MyText2",
        :help_type => "faq"
      ),
      stub_model(Help,
        :name => "Name3",
        :title => "Help Title3",
        :description => "MyText3",
        :help_type => "topic"
      )
    ])
  end

  it "renders a list of helps" do
    render
    assert_select "a", :content => /Name1/    # it's content for 'a', not 'text'
    assert_select "a", :content => /Name2/
    assert_select "a", :content => /Name3/
    # TBD:  New Name should only appear if we are admin
    assert_select "a", :content => /New Name/
  end
end

