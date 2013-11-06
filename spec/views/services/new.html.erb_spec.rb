require 'spec_helper'

describe "services/new" do
  before(:each) do
    assign(:service, stub_model(Service,
      :person_id => 1,
      :service_type => "talkinvite",
      :service_notes => "MyText"
    ).as_new_record)
  end

  it "renders new service form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", services_path, "post" do
      assert_select "input#service_person_id[name=?]", "service[person_id]"
      assert_select "input#service_service_type[name=?]", "service[service_type]"
      assert_select "textarea#service_service_notes[name=?]", "service[service_notes]"
    end
  end
end
