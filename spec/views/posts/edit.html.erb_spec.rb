require 'spec_helper'

# TBD:  how to manage nested paths in view specs? and is it worth the trouble?
=begin
describe "posts/edit" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :person_id => 1,
      :talk_id => 1,
      :routing => "MyString",
      :post_type => "MyString",
      :post_message => "MyText"
    ))
  end

  it "renders the edit post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", post_path(@post), "post" do
      assert_select "input#post_person_id[name=?]", "post[person_id]"
      assert_select "input#post_talk_id[name=?]", "post[talk_id]"
      assert_select "input#post_routing[name=?]", "post[routing]"
      assert_select "input#post_post_type[name=?]", "post[post_type]"
      assert_select "textarea#post_post_message[name=?]", "post[post_message]"
    end
  end
end
=end
