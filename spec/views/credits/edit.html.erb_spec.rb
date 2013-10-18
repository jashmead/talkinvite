require 'spec_helper'

describe "credits/edit" do
  before(:each) do
    @credit = assign(:credit, stub_model(Credit,
      :name => "MyText",
      :description => "MyText"
    ))
  end

  it "renders the edit credit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", credit_path(@credit), "post" do
      assert_select "textarea#credit_name[name=?]", "credit[name]"
      assert_select "textarea#credit_description[name=?]", "credit[description]"
    end
  end
end
