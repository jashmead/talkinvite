require 'spec_helper'

describe "attachments/edit" do
  before(:each) do
    @attachment = assign(:attachment, stub_model(Attachment,
      :person_id => 1,
      :name => "MyString",
      :description => "MyText",
      :file_type => "MyString",
      :pathname => "MyString",
      :attachable_type => "MyString",
      :attachable_id => 1
    ))
  end

  it "renders the edit attachment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", attachment_path(@attachment), "post" do
      assert_select "input#attachment_person_id[name=?]", "attachment[person_id]"
      assert_select "input#attachment_name[name=?]", "attachment[name]"
      assert_select "textarea#attachment_description[name=?]", "attachment[description]"
      assert_select "input#attachment_file_type[name=?]", "attachment[file_type]"
      assert_select "input#attachment_pathname[name=?]", "attachment[pathname]"
      assert_select "input#attachment_attachable_type[name=?]", "attachment[attachable_type]"
      assert_select "input#attachment_attachable_id[name=?]", "attachment[attachable_id]"
    end
  end
end
