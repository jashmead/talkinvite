require 'spec_helper'

describe "tags/index" do
  before(:each) do
    assign(:tags, [
      stub_model(Tag,
        :tag_type => "Tag Type",
        :tagable => nil
      ),
      stub_model(Tag,
        :tag_type => "Tag Type",
        :tagable => nil
      )
    ])
  end

  it "renders a list of tags" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Tag Type".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
