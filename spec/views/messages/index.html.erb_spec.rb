require 'spec_helper'

describe "messages/index" do
  before(:each) do
    assign(:messages, [
      stub_model(Message,
        :sender_id => 1,
        :receiver_id => 2,
        :message_type => "Message Type",
        :message_text => "MyText"
      ),
      stub_model(Message,
        :sender_id => 1,
        :receiver_id => 2,
        :message_type => "Message Type",
        :message_text => "MyText"
      )
    ])
  end

  it "renders a list of messages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Message Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
