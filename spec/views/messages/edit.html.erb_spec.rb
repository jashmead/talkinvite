require 'spec_helper'

describe "messages/edit" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :sender_id => 1,
      :receiver_id => 1,
      :message_type => "MyString",
      :message_text => "MyText"
    ))
  end

  it "renders the edit message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", message_path(@message), "post" do
      assert_select "input#message_sender_id[name=?]", "message[sender_id]"
      assert_select "input#message_receiver_id[name=?]", "message[receiver_id]"
      assert_select "input#message_message_type[name=?]", "message[message_type]"
      assert_select "textarea#message_message_text[name=?]", "message[message_text]"
    end
  end
end
