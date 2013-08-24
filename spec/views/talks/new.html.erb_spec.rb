require 'spec_helper'

describe "talks/new" do
  before(:each) do
    assign(:talk, stub_model(Talk,
      :summary => "MyString",
      :description => "MyText",
      :location_id => 1
    ).as_new_record)
  end

  it "renders new talk form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", talks_path, "post" do
      assert_select "input#talk_summary[name=?]", "talk[summary]"
      assert_select "textarea#talk_description[name=?]", "talk[description]"
      assert_select "input#talk_location_id[name=?]", "talk[location_id]"
    end
  end
end
