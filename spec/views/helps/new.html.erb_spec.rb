require 'spec_helper'

describe "helps/new" do
  before(:each) do
    assign(:help, stub_model(Help,
      :name => "MyString",
      :title => "Help Title",
      :description => "MyText",
      :help_type => "page"
    ).as_new_record)
  end

  it "renders new help form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", helps_path, "post" do
      assert_select "input#help_name[name=?]", "help[name]"
      # assert_select "textarea#help_title[name=?]", "help[title]"
      assert_select "input#help_title[name=?]", "help[title]"
      assert_select "textarea#help_description[name=?]", "help[description]"
      assert_select "select#help_help_type[name=?]", "help[help_type]"
    end
  end
end
