require 'spec_helper'

describe "venues/new" do
  before(:each) do
    assign(:venue, stub_model(Venue,
      :person_id => 1,
      :name => "MyString",
      :description => "MyText",
      :longitude => "9.99",
      :latitude => "9.99",
      :venue_type => "MyString"
    ).as_new_record)
  end

  it "renders new venue form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", venues_path, "post" do
      assert_select "input#venue_person_id[name=?]", "venue[person_id]"
      assert_select "input#venue_name[name=?]", "venue[name]"
      assert_select "textarea#venue_description[name=?]", "venue[description]"
      assert_select "input#venue_longitude[name=?]", "venue[longitude]"
      assert_select "input#venue_latitude[name=?]", "venue[latitude]"
      assert_select "input#venue_venue_type[name=?]", "venue[venue_type]"
    end
  end
end
