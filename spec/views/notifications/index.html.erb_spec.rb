require 'spec_helper'

describe "notifications/index" do
  before(:each) do
    assign(:notifications, [
      stub_model(Notification,
        :person_id => 1,
        :talk_id => 2,
        :note_type => "Note Type",
        :note_text => "MyText1"
      ),
      stub_model(Notification,
        :person_id => 1,
        :talk_id => 2,
        :note_type => "Note Type",
        :note_text => "MyText1"
      )
    ])
  end

  it "renders a list of notifications" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "a", :content => /MyText1/    # it's content for 'a', not 'text'
    assert_select "a", :content => /MyText2/
    assert_select "a", :content => /New Notification/
  end
end
