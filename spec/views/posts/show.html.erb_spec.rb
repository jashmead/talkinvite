require 'spec_helper'

describe "posts/show" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :person_id => 1,
      :talk_id => 2,
      :post_type => "Post Type",
      :comment => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Post Type/)
    rendered.should match(/MyText/)
  end
end
