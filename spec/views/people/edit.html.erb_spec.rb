require 'spec_helper'

describe "people/edit" do
  before(:each) do
    @person = assign(:person, stub_model(Person,
      :name => "MyString",
      :email => "MyString",
      :about_me => "MyText",
      :twitter_handle => "MyString",
      :settings => "MyString"
    ))
  end

  it "renders the edit person form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", person_path(@person), "post" do
      assert_select "input#person_name[name=?]", "person[name]"
      assert_select "input#person_email[name=?]", "person[email]"
      assert_select "textarea#person_about_me[name=?]", "person[about_me]"
      assert_select "input#person_twitter_handle[name=?]", "person[twitter_handle]"
      assert_select "input#person_settings[name=?]", "person[settings]"
    end
  end
end
