require 'spec_helper'

describe "members/index" do
  before(:each) do
    assign(:members, [
      stub_model(Member,
        :talk_id => 1,
        :person_id => 2,
        :rsvp_status => "accepted",
        :member_type => "member"
      ),
      stub_model(Member,
        :talk_id => 1,
        :person_id => 2,
        :rsvp_status => "declined",
        :member_type => "admin"
      )
    ])
  end

  it "renders a list of members" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "a", :content => /accepted/
    assert_select "a", :content => /declined/
    assert_select "a", :content => /New Member/
  end
end
