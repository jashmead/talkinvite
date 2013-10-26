require 'spec_helper'

describe "tags/index" do
  before(:each) do
    assign(:tags, [
      stub_model(Tag,
        :tag_type => "sports",
        :tagable => nil
      ),
      stub_model(Tag,
        :tag_type => "movies",
        :tagable => nil
      )
    ])
  end

  it "renders a list of tags" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "a", :content => /sports/    # it's content for 'a', not 'text'
    assert_select "a", :content => /movies/
    assert_select "a", :content => /New Tag/
  end
end
