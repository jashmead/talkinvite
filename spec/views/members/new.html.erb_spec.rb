require 'spec_helper'

describe "members/new" do
  before(:each) do
    assign(:member, stub_model(Member,
      :talk_id => 1,
      :person_id => 1,
      :rsvp_status => "MyString",
      :member_type => "MyString"
    ).as_new_record)
  end

  it "renders new member form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", members_path, "post" do
      assert_select "input#member_talk_id[name=?]", "member[talk_id]"
      assert_select "input#member_person_id[name=?]", "member[person_id]"
      assert_select "input#member_rsvp_status[name=?]", "member[rsvp_status]"
      assert_select "input#member_member_type[name=?]", "member[member_type]"
    end
  end
end
