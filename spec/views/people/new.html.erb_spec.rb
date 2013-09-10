# 'about_me' not working, perhaps something to do with it being a text_area?
require 'spec_helper'

describe "people/new" do
  before(:each) do
    assign(:person, stub_model(Person,
      :name => "MyName",
      :email => "me@talkinvite.com",
      :about_me => "Its all about me!",
      :screen_name => "MyScreenName",
      :settings => "MySettings"
    ).as_new_record)
  end

  it "renders new person form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", people_path, "post" do
      assert_select "input#person_name[name=?]", "person[name]"
      assert_select "input#person_email[name=?]", "person[email]"
      assert_select "textarea#person_about_me[name=?]", "person[about_me]"
      assert_select "input#person_screen_name[name=?]", "person[screen_name]"
      assert_select "input#person_settings[name=?]", "person[settings]"
    end
  end
end
