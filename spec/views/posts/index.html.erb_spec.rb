require 'spec_helper'

describe "posts/index" do
  before(:each) do
    assign(:posts, [
      stub_model(Post,
        :person_id => 1,
        :talk_id => 2,
        :service_type => "Service Type",
        :service_notes => "MyText",
        :post_type => "Post Type",
        :post_message => "MyMessage"
      ),
      stub_model(Post,
        :person_id => 1,
        :talk_id => 2,
        :service_type => "Service Type",
        :service_notes => "MyText",
        :post_type => "Post Type",
        :post_message => "MyMessage"
      )
    ])
  end

  it "renders a list of posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Service Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Post Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyMessage".to_s, :count => 2
  end
end
