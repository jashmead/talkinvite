require 'spec_helper'

describe "calendars/edit" do
  before(:each) do
    @calendar = assign(:calendar, stub_model(Calendar,
      :person_id => 1,
      :talk_id => 1,
      :name => "MyText",
      :description => "MyDescription",
      :scale => "day"
    ))
  end

  it "renders the edit calendar form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", calendar_path(@calendar), "post" do
      assert_select "input#calendar_person_id[name=?]", "calendar[person_id]"
      assert_select "input#calendar_talk_id[name=?]", "calendar[talk_id]"
      assert_select "input#calendar_name[name=?]", "calendar[name]"
    end
  end
end
