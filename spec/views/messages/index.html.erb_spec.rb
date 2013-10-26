require 'spec_helper'

describe "messages/index" do
  before(:each) do
    assign(:messages, [
      stub_model(Message,
        :sender_id => 1,
        :receiver_id => 2,
        :message_type => "Message Type",
        :message_text => "MyText1"
      ),
      stub_model(Message,
        :sender_id => 1,
        :receiver_id => 2,
        :message_type => "Message Type",
        :message_text => "MyText2"
      )
    ])
  end

  it "renders a list of messages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "a", :content => /MyText1/    # it's content for 'a', not 'text'
    assert_select "a", :content => /MyText2/
    assert_select "a", :content => /New Message/
  end
end
