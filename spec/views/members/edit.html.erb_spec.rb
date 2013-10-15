require 'spec_helper'

describe "members/edit" do
  before(:each) do
    @member = assign(:member, stub_model(Member,
      :talk_id => 1,
      :person_id => 1,
      :rsvp_status => "MyString",
      :member_type => "MyString"
    ))
  end

  it "renders the edit member form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", member_path(@member), "post" do
      assert_select "input#member_talk_id[name=?]", "member[talk_id]"
      assert_select "input#member_person_id[name=?]", "member[person_id]"
      assert_select "input#member_rsvp_status[name=?]", "member[rsvp_status]"
      assert_select "input#member_member_type[name=?]", "member[member_type]"
    end
  end
end
