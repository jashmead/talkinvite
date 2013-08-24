require 'spec_helper'

describe "messages/index" do
  before(:each) do
    assign(:messages, [
      stub_model(Message,
        :from_person_id => 1,
        :to_person_id => 2,
        :talk_id => 3,
        :message_type => "Message Type",
        :content => "MyText"
      ),
      stub_model(Message,
        :from_person_id => 1,
        :to_person_id => 2,
        :talk_id => 3,
        :message_type => "Message Type",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of messages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Message Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
