require 'spec_helper'

describe "maps/edit" do
  before(:each) do
    @map = assign(:map, stub_model(Map,
      :user_id => 1,
      :name => "MyString",
      :description => "MyText",
      :location_id => 1,
      :settings => "MyText"
    ))
  end

  it "renders the edit map form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", map_path(@map), "post" do
      assert_select "input#map_user_id[name=?]", "map[user_id]"
      assert_select "input#map_name[name=?]", "map[name]"
      assert_select "textarea#map_description[name=?]", "map[description]"
      assert_select "input#map_location_id[name=?]", "map[location_id]"
      assert_select "textarea#map_source[name=?]", "map[source]"
      assert_select "textarea#map_settings[name=?]", "map[settings]"
    end
  end
end
