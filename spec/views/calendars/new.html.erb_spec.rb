require 'spec_helper'

describe "calendars/new" do
  before(:each) do
    assign(:calendar, stub_model(Calendar,
      :person_id => 1,
      :name => "MyString",
      :description => "MyText",
      :source => "MyString",
      :settings => "MyText"
    ).as_new_record)
  end

  it "renders new calendar form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", calendars_path, "post" do
      assert_select "input#calendar_person_id[name=?]", "calendar[person_id]"
      assert_select "input#calendar_name[name=?]", "calendar[name]"
      assert_select "textarea#calendar_description[name=?]", "calendar[description]"
      assert_select "input#calendar_source[name=?]", "calendar[source]"
      assert_select "textarea#calendar_settings[name=?]", "calendar[settings]"
    end
  end
end
