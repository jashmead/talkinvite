require 'spec_helper'

describe "partners/index" do
  before(:each) do
    assign(:partners, [
      stub_model(Partner,
        :talk_id => 1,
        :person_id => 2,
        :rsvp_status => "yes",
        :partner_type => "partner"
      ),
      stub_model(Partner,
        :talk_id => 1,
        :person_id => 2,
        :rsvp_status => "no",
        :partner_type => "admin"
      )
    ])
  end

  it "renders a list of partners" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "a", :content => /yes/
    assert_select "a", :content => /no/
    assert_select "a", :content => /New Partner/
  end
end
