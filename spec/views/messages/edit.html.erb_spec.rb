require 'spec_helper'

describe "messages/edit" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :from_person_id => 1,
      :to_person_id => 1,
      :talk_id => 1,
      :message_type => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", message_path(@message), "post" do
      assert_select "input#message_from_person_id[name=?]", "message[from_person_id]"
      assert_select "input#message_to_person_id[name=?]", "message[to_person_id]"
      assert_select "input#message_talk_id[name=?]", "message[talk_id]"
      assert_select "input#message_message_type[name=?]", "message[message_type]"
      assert_select "textarea#message_content[name=?]", "message[content]"
    end
  end
end
