require 'spec_helper'

describe "people/change_password" do
  before(:each) do
    @person = assign(:person, stub_model(Person,
      :name => "MyString",
      :email => "MyString",
      :description => "About Me"
    ))
  end

  it "renders the change password form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", person_path(@person), "post" do
      # rendered.should match(/MyName/)           # name not appearing?
      # assert_select "input#person_name[name=?]", "person[name]"
      assert_select "input#person_email[name=?]", "person[email]"
      assert_select "textarea#person_description[name=?]", "person[description]"
    end
  end
end
