require 'spec_helper'

describe "notifications/new" do
  before(:each) do
    assign(:notification, stub_model(Notification,
      :person_id => 1,
      :talk_id => 1,
      :note_type => "MyString",
      :note_text => "MyText"
    ).as_new_record)
  end

  it "renders new notification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", notifications_path, "post" do
      assert_select "input#notification_person_id[name=?]", "notification[person_id]"
      assert_select "input#notification_talk_id[name=?]", "notification[talk_id]"
      assert_select "input#notification_note_type[name=?]", "notification[note_type]"
      assert_select "textarea#notification_note_text[name=?]", "notification[note_text]"
    end
  end
end
