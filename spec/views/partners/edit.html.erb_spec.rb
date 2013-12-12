require 'spec_helper'

describe "partners/edit" do
  before(:each) do
    @partner = assign(:partner, stub_model(Partner,
      :talk_id => 1,
      :person_id => 1,
      :rsvp_status => "MyString",
      :partner_type => "MyString"
    ))
  end

  it "renders the edit partner form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", partner_path(@partner), "post" do
      assert_select "input#partner_talk_id[name=?]", "partner[talk_id]"
      assert_select "input#partner_person_id[name=?]", "partner[person_id]"
      assert_select "input#partner_rsvp_status[name=?]", "partner[rsvp_status]"
      assert_select "input#partner_partner_type[name=?]", "partner[partner_type]"
    end
  end
end
