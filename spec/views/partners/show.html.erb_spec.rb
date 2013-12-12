require 'spec_helper'

describe "partners/show" do
  before(:each) do
    @partner = assign(:partner, stub_model(Partner,
      :talk_id => 1,
      :person_id => 2,
      :rsvp_status => "Rsvp Status",
      :partner_type => "Partner Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Rsvp Status/)
    rendered.should match(/Partner Type/)
  end
end
