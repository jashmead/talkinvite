require 'spec_helper'

describe "credits/new" do
  before(:each) do
    assign(:credit, stub_model(Credit,
      :worthy_one => "MyText",
      :service_supplied => "MyText"
    ).as_new_record)
  end

  it "renders new credit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", credits_path, "post" do
      assert_select "textarea#credit_worthy_one[name=?]", "credit[worthy_one]"
      assert_select "textarea#credit_service_supplied[name=?]", "credit[service_supplied]"
    end
  end
end
