require 'spec_helper'

describe "credits/edit" do
  before(:each) do
    @credit = assign(:credit, stub_model(Credit,
      :worthy_one => "MyText",
      :service_supplied => "MyText"
    ))
  end

  it "renders the edit credit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", credit_path(@credit), "post" do
      assert_select "textarea#credit_worthy_one[name=?]", "credit[worthy_one]"
      assert_select "textarea#credit_service_supplied[name=?]", "credit[service_supplied]"
    end
  end
end
