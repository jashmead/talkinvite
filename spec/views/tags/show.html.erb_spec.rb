require 'spec_helper'

describe "tags/show" do
  before(:each) do
    @tag = assign(:tag, stub_model(Tag,
      :tagable_type => "Tagable Type",
      :tabable_id => 1,
      :tag_type => "Tag Type",
      :tag => "Tag"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Tagable Type/)
    rendered.should match(/1/)
    rendered.should match(/Tag Type/)
    rendered.should match(/Tag/)
  end
end
