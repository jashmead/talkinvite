require 'spec_helper'

describe "tags/edit" do
  before(:each) do
    @tag = assign(:tag, stub_model(Tag,
      :tagable_type => "MyString",
      :tabable_id => 1,
      :tag_type => "MyString",
      :tag => "MyString"
    ))
  end

  it "renders the edit tag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tag_path(@tag), "post" do
      assert_select "input#tag_tagable_type[name=?]", "tag[tagable_type]"
      assert_select "input#tag_tabable_id[name=?]", "tag[tabable_id]"
      assert_select "input#tag_tag_type[name=?]", "tag[tag_type]"
      assert_select "input#tag_tag[name=?]", "tag[tag]"
    end
  end
end
