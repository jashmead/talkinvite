require 'spec_helper'

describe "services/edit" do
  before(:each) do
    @service = assign(:service, stub_model(Service,
      :person_id => 1,
      :service_type => "MyString",
      :service_notes => "MyText"
    ))
  end

  it "renders the edit service form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", service_path(@service), "post" do
      assert_select "input#service_person_id[name=?]", "service[person_id]"
      assert_select "input#service_service_type[name=?]", "service[service_type]"
      assert_select "textarea#service_service_notes[name=?]", "service[service_notes]"
    end
  end
end
