require 'spec_helper'

describe "credits/new" do
  before(:each) do
    assign(:credit, stub_model(Credit,
      :name => "MyText",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new credit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", credits_path, "post" do
      assert_select "textarea#credit_name[name=?]", "credit[name]"
      assert_select "textarea#credit_description[name=?]", "credit[description]"
    end
  end
end
