require 'spec_helper'

describe "calendars/edit" do
  before(:each) do
    @calendar = assign(:calendar, stub_model(Calendar,
      :user_id => 1,
      :name => "MyString",
      :description => "MyText",
      :source => "MyString",
      :settings => "MyText"
    ))
  end

  it "renders the edit calendar form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", calendar_path(@calendar), "post" do
      assert_select "input#calendar_user_id[name=?]", "calendar[user_id]"
      assert_select "input#calendar_name[name=?]", "calendar[name]"
      assert_select "textarea#calendar_description[name=?]", "calendar[description]"
      assert_select "input#calendar_source[name=?]", "calendar[source]"
      assert_select "textarea#calendar_settings[name=?]", "calendar[settings]"
    end
  end
end
