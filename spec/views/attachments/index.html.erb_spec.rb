require 'spec_helper'

describe "attachments/index" do
  before(:each) do
    assign(:attachments, [
      stub_model(Attachment,
        :name => "Name1",
        :description => "MyText",
        :attachment_type => "Attachment Type",
        :attachable_type => "Attachable Type",
        :attachable_id => 1,
        :file_path => "File Path"
      ),
      stub_model(Attachment,
        :name => "Name2",
        :description => "MyText",
        :attachment_type => "Attachment Type",
        :attachable_type => "Attachable Type",
        :attachable_id => 1,
        :file_path => "File Path"
      )
    ])
  end

  it "renders a list of attachments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "a", :content => 'MyName1'
    assert_select "a", :content => 'MyName2'
    assert_select "a", :content => 'New Attachment'
  end
end
