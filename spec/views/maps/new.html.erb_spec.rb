require 'spec_helper'

describe "maps/new" do
  before(:each) do
    assign(:map, stub_model(Map,
      :user_id => 1,
      :name => "MyString",
      :description => "MyText",
      :location_id => 1,
      :source => "MyText",
      :settings => "MyText"
    ).as_new_record)
  end

  it "renders new map form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", maps_path, "post" do
      assert_select "input#map_user_id[name=?]", "map[user_id]"
      assert_select "input#map_name[name=?]", "map[name]"
      assert_select "textarea#map_description[name=?]", "map[description]"
      assert_select "input#map_location_id[name=?]", "map[location_id]"
      assert_select "textarea#map_source[name=?]", "map[source]"
      assert_select "textarea#map_settings[name=?]", "map[settings]"
    end
  end
end
