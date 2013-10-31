require 'spec_helper'

describe "posts/new" do
  before(:each) do
    assign(:post, stub_model(Post,
      :person_id => 1,
      :talk_id => 1,
      :service_type => "MyString",
      :service_notes => "MyText",
      :post_type => "MyString",
      :post_message => "MyText"
    ).as_new_record)
  end

  it "renders new post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", posts_path, "post" do
      assert_select "input#post_person_id[name=?]", "post[person_id]"
      assert_select "input#post_talk_id[name=?]", "post[talk_id]"
      assert_select "input#post_service_type[name=?]", "post[service_type]"
      assert_select "textarea#post_service_notes[name=?]", "post[service_notes]"
      assert_select "input#post_post_type[name=?]", "post[post_type]"
      assert_select "textarea#post_post_message[name=?]", "post[post_message]"
    end
  end
end
