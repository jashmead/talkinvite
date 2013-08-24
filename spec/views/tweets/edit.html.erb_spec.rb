require 'spec_helper'

describe "tweets/edit" do
  before(:each) do
    @tweet = assign(:tweet, stub_model(Tweet,
      :person_id => 1,
      :screen_name => "MyString",
      :content => "MyString",
      :location_id => 1
    ))
  end

  it "renders the edit tweet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tweet_path(@tweet), "post" do
      assert_select "input#tweet_person_id[name=?]", "tweet[person_id]"
      assert_select "input#tweet_screen_name[name=?]", "tweet[screen_name]"
      assert_select "input#tweet_content[name=?]", "tweet[content]"
      assert_select "input#tweet_location_id[name=?]", "tweet[location_id]"
    end
  end
end
