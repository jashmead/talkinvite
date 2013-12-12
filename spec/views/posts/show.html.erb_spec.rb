require 'spec_helper'

# TBD:  how to manage nested paths in view specs? and is it worth the trouble?
=begin
describe "people/1/talks/2/posts/show" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :person_id => 1,
      :talk_id => 2,
      :routing => "message",
      :post_type => "Post Type",
      :post_message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/message/)
    rendered.should match(/Post Type/)
    rendered.should match(/MyText/)
  end
end
=end
