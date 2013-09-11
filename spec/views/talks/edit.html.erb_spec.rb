require 'spec_helper'

describe "talks/edit" do
  before(:each) do
    @talk = assign(:talk, stub_model(Talk,
      :summary => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit talk form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", talk_path(@talk), "post" do
      assert_select "input#talk_summary[name=?]", "talk[summary]"
      assert_select "textarea#talk_description[name=?]", "talk[description]"
    end
  end
end
