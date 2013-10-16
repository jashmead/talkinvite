require 'spec_helper'

describe "maps/new" do
  before(:each) do
    assign(:map, stub_model(Map,
      :name => "MyString",
      :description => "MyString",
      :geometry => "MyText",
      :settings => "MyText",
      :history => "MyText"
    ).as_new_record)
  end

  it "renders new map form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", maps_path, "post" do
      assert_select "input#map_name[name=?]", "map[name]"
      assert_select "input#map_description[name=?]", "map[description]"
      assert_select "textarea#map_geometry[name=?]", "map[geometry]"
      assert_select "textarea#map_settings[name=?]", "map[settings]"
      assert_select "textarea#map_history[name=?]", "map[history]"
    end
  end
end
