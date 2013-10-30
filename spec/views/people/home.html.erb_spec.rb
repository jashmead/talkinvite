require 'spec_helper'

describe "people/home" do
  before(:each) do
    @person = assign(:person, stub_model(Person,
      :name => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the home person form" do
    render

=begin
    # check for friends & other 'my' forms linked to from here
    assert_select "form[action=?][method=?]", person_path(@person), "post" do
      assert_select "input#person_name[name=?]", "person[name]"
      assert_select "input#person_email[name=?]", "person[email]"
    end
=end
  end

end
