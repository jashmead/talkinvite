require 'spec_helper'

describe "members/index" do
  before(:each) do
    assign(:members, [
      stub_model(Member,
        :talk_id => 1,
        :person_id => 2,
        :rsvp_status => "Rsvp Status",
        :member_type => "Member Type"
      ),
      stub_model(Member,
        :talk_id => 1,
        :person_id => 2,
        :rsvp_status => "Rsvp Status",
        :member_type => "Member Type"
      )
    ])
  end

  it "renders a list of members" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Rsvp Status".to_s, :count => 2
    assert_select "tr>td", :text => "Member Type".to_s, :count => 2
  end
end
