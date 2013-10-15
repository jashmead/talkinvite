require 'spec_helper'

describe "comments/new" do
  before(:each) do
    assign(:comment, stub_model(Comment,
      :person_id => 1,
      :talk_id => 1,
      :comment_text => "MyText"
    ).as_new_record)
  end

  it "renders new comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", comments_path, "post" do
      assert_select "input#comment_person_id[name=?]", "comment[person_id]"
      assert_select "input#comment_talk_id[name=?]", "comment[talk_id]"
      assert_select "textarea#comment_comment_text[name=?]", "comment[comment_text]"
    end
  end
end
