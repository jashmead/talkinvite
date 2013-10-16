require 'spec_helper'

describe "attachments/edit" do
  before(:each) do
    @attachment = assign(:attachment, stub_model(Attachment,
      :name => "MyString",
      :description => "MyText",
      :attachment_type => "MyString",
      :attachable_type => "MyString",
      :attachable_id => 1,
      :file_path => "MyString"
    ))
  end

  it "renders the edit attachment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", attachment_path(@attachment), "post" do
      assert_select "input#attachment_name[name=?]", "attachment[name]"
      assert_select "textarea#attachment_description[name=?]", "attachment[description]"
      assert_select "input#attachment_attachment_type[name=?]", "attachment[attachment_type]"
      assert_select "input#attachment_attachable_type[name=?]", "attachment[attachable_type]"
      assert_select "input#attachment_attachable_id[name=?]", "attachment[attachable_id]"
      assert_select "input#attachment_file_path[name=?]", "attachment[file_path]"
    end
  end
end
