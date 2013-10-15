require 'spec_helper'

describe "members/show" do
  before(:each) do
    @member = assign(:member, stub_model(Member,
      :talk_id => 1,
      :person_id => 2,
      :rsvp_status => "Rsvp Status",
      :member_type => "Member Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Rsvp Status/)
    rendered.should match(/Member Type/)
  end
end
