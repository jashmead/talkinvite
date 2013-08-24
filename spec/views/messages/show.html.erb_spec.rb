require 'spec_helper'

describe "messages/show" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :from_person_id => 1,
      :to_person_id => 2,
      :talk_id => 3,
      :message_type => "Message Type",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Message Type/)
    rendered.should match(/MyText/)
  end
end
