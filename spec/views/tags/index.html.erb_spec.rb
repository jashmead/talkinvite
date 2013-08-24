require 'spec_helper'

describe "tags/index" do
  before(:each) do
    assign(:tags, [
      stub_model(Tag,
        :tagable_type => "Tagable Type",
        :tabable_id => 1,
        :tag_type => "Tag Type",
        :tag => "Tag"
      ),
      stub_model(Tag,
        :tagable_type => "Tagable Type",
        :tabable_id => 1,
        :tag_type => "Tag Type",
        :tag => "Tag"
      )
    ])
  end

  it "renders a list of tags" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Tagable Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Tag Type".to_s, :count => 2
    assert_select "tr>td", :text => "Tag".to_s, :count => 2
  end
end
