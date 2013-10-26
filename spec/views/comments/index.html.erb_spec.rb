require 'spec_helper'

describe "comments/index" do
  before(:each) do
    assign(:comments, [
      stub_model(Comment,
        :person_id => 1,
        :talk_id => 2,
        :comment_text => "MyComment1"
      ),
      stub_model(Comment,
        :person_id => 1,
        :talk_id => 2,
        :comment_text => "MyComment2"
      )
    ])
  end

  it "renders a list of comments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "a", :content => 'MyComment1'
    assert_select "a", :content => 'MyComment2'
    assert_select "a", :content => 'New Comment'
  end
end
