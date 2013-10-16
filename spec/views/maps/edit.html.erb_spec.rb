require 'spec_helper'

describe "maps/edit" do
  before(:each) do
    @map = assign(:map, stub_model(Map,
      :name => "MyString",
      :description => "MyString",
      :geometry => "MyText",
      :settings => "MyText",
      :history => "MyText"
    ))
  end

  it "renders the edit map form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", map_path(@map), "post" do
      assert_select "input#map_name[name=?]", "map[name]"
      assert_select "input#map_description[name=?]", "map[description]"
      assert_select "textarea#map_geometry[name=?]", "map[geometry]"
      assert_select "textarea#map_settings[name=?]", "map[settings]"
      assert_select "textarea#map_history[name=?]", "map[history]"
    end
  end
end
